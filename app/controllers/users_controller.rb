class UsersController < ApplicationController
    
    before_action :set_user, only: [:show, :edit, :update, :destroy]
    
    before_action :require_user, only: [:edit, :update]
    before_action :require_same_user, only: [:edit, :update, :destroy]

    def show
        #@articles = @user.articles
        @articles = @user.articles.paginate(page: params[:page], per_page: 3)
    end

    def index
        #@users = User.all
        @users = User.paginate(page: params[:page], per_page: 3)
    end

    def new
        @user = User.new
    end

    def edit
        @user = User.find(params[:id])
        # unless logged_in? && current_user == @user
        #     redirect_to user_path(current_user)
        #     flash[:warning] = "Only logged in #{@user.username} can edit their own profile."
        # end
    end

    def update

        if @user.update(user_params_ww)
            flash[:notice] = "Your account was successfully updated."
            redirect_to @user
        else
            render 'edit'
        end
    end

    def create
        #byebug
        @user = User.new(user_params_ww)
        if @user.save
            flash[:notice] = "Welcome to the Alpha Blog #{@user.username}. You have successfully signed up."
            session[:user_id] = @user.id
            redirect_to user_path(@user)

        else 
            render 'new'
        end
    end

    def destroy
        @user.destroy
        session[:user_id] = nil if @user == current_user
        flash[:notice] = "Account all associated articles successfully deleted"
        redirect_to root_path
        #session[:user_id] == nil ? redirect_to(root_path) : redirect_to(users_path)
    end

#    nexti==0 ? redirect_to(:back) : redirect_to(edit_playt_path({id: actform['playt_id'], i: nexti}))


    private

    def user_params_ww
        params.require(:user).permit(:username, :email, :password)
    end

    def set_user
        @user = User.find(params[:id])
    end

    def require_same_user
        if current_user != @user && !current_user.admin?
            flash[:alert] = "You can only edit or delete your own account"
            redirect_to @user
        end
    end
end