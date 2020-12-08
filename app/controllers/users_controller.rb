class UsersController < ApplicationController

    def new
        @user = User.new
    end

    def create
        #byebug
        @user = User.new(user_params_ww)
        if @user.save
            flash[:notice] = "Welcome to the Alpha Blog #{@user.username}. You have successfully signed up."
            redirect_to articles_path
        else 
            render 'new'
        end
    end

    private

    def user_params_ww
        params.require(:user).permit(:username, :email, :password)
    end
end