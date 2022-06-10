class SessionsController < ApplicationController
    def create
        user = User.find_by(username: params[:username])
        if user&.authenticate(params[:password])
            session[:user_id] = user.id
            return render json: user, status: 200
        else
            render json: user, status: 401
        end
    end

    def destroy
        session.delete :user_id
        head :no_content
    end
end
