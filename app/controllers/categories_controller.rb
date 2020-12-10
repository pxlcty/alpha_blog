class CategoriesController < ApplicationController
    before_action :require_amin, except: [:index, :show]

    def index
        @categories = Category.all
        @categories = Category.paginate(page: params[:page], per_page: 5)
    end

    def create
        @category = Category.new(category_params_ww)
        if @category.save
            flash[:notice] = "Category was successfully created"
            redirect_to @category
        else
            render 'new'
        end
    end

    def show
        @category = Category.find(params[:id])
    end

    def new
        @category = Category.new
    end

    private

    def category_params_ww
        params.require(:category).permit(:name)
    end

    def require_amin
        if !(logged_in? && current_user.admin?)
            flash[:alert] = "Only admins can perform taht action"
            redirect_to categories_path
        end
    end


end