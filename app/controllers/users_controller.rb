class UsersController < ApplicationController

    def create
        user = User.create(user_params)
  
        if user.valid?
            session[:user_id] = user.id
            render json: user, status: :created
        else
            render json: {error: user.errors}, status: :unprocessable_entity
        end
    end

    def show
        
        return render json: {errors: "Not logged in"}, status: 401 unless session[:user_id]

        user = User.find_by(id: session[:user_id])
        render json: user, status: 200

    end

    private

    def user_params
        params.permit(:username, :password, :password_confirmation)
    end

end
