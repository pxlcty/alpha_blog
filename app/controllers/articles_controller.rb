class ArticlesController < ApplicationController

    def index
        @articles = Article.all
    end

    def show
        #byebug
        @article = Article.find(params[:id])
    end

    def new
        @article = Article.new
    end

    def edit
        #byebug
        @article = Article.find(params[:id])
    end

    def create
        # in the Rails S output we can see the Parameter hash.
        # in that hash, we can see one of the keys are "article" hence we pull it out below to display basic output.
        # render plain: params[:article]
        # with that :article key we can use that to create to the DB : 
        # @article = Article.new(params[:article]) # won't work
        # whitelist the :title & description data in the article hash:
        @article = Article.new(params.require(:article).permit(:title, :description))
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
        @article = Article.find(params[:id])
        if @article.update(params.require(:article).permit(:title, :description))
            flash[:notice] = "Article was updated successfully."
            redirect_to @article
        else
            render 'edit'
        end
    end

    def destroy
        @article = Article.find(params[:id])
        @article.destroy
        redirect_to articles_path # /articles
    end




end