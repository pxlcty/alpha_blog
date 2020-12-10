class ArticlesController < ApplicationController

    before_action :set_article, only: [:show, :edit, :update, :destroy]
    before_action :require_user, except: [:show, :index]
    before_action :require_same_user, only: [:edit, :update, :destroy]

    def index
        #@articles = Article.all
        @articles = Article.paginate(page: params[:page], per_page: 5)
    end

    def show
        #byebug
    end

    def new
        @article = Article.new
    end

    def edit
        #byebug
    end

    def create
        # in the Rails S output we can see the Parameter hash.
        # in that hash, we can see one of the keys are "article" hence we pull it out below to display basic output.
        # render plain: params[:article]
        # with that :article key we can use that to create to the DB : 
        # @article = Article.new(params[:article]) # won't work
        # whitelist the :title & description data in the article hash:
        @article = Article.new(article_params_white_wash)
        @article.user = current_user
        #render plain: @article.inspect
        if @article.save
            flash[:notice] = "Article was created successfully."
            # url is created by 'article_path' => articles (Routes files for articles#show is /articles/:id)
            # and the @article will pull out the :id to create articles/:id
            #redirect_to article_path(@article)
            #short hand for above is this : 
            redirect_to @article
        else 
            render 'new'
        end

    end

    def update
        #byebug
        if @article.update(article_params_white_wash)
            flash[:notice] = "Article was updated successfully."
            redirect_to @article
        else
            render 'edit'
        end
    end

    def destroy
        
        @article.destroy
        redirect_to articles_path # /articles
    end

    private # only accessable via controller, not outside that.
    def set_article
        @article = Article.find(params[:id])
    end

    def article_params_white_wash
        params.require(:article).permit(:title, :description)
    end

    def require_same_user
        if current_user != @article.user
            flash[:alert] = "You can only edit or delete your own article"
            redirect_to @article
        end
    end




end