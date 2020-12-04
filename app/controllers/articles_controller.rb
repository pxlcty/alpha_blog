class ArticlesController < ApplicationController

    def index
        @articles = Article.all
    end

    def show
        #byebug
        @article = Article.find(params[:id])
    end

    def create
        # in the Rails S output we can see the Parameter hash.
        # in that hash, we can see one of the keys are "article" hence we pull it out below to display basic output.
        render plain: params[:article]
    end

    def new
    end



end