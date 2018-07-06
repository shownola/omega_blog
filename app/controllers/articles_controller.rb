class ArticlesController < ApplicationController
  before_action :find_article, only: [:show, :edit, :update, :destroy]
  
  def index
    @articles = Article.paginate(page: params[:page], per_page: 10)
  end
  
  def new
    @article = Article.new
  end
  
  def create
    @article = Article.new(article_params)
    @article.user = User.last
    if @article.save
      flash[:success] = 'Article has been created'
      redirect_to @article
    else
      render 'new'
    end
  end
  
  def show
    @article = Article.find(params[:id])
  end
  
  def edit
  end
  
  def update
    if @article.update(article_params)
      flash[:success] = 'Article has been updated'
      redirect_to @article
    else
      render 'edit'
    end
  end
  
  def destroy
    @article.destroy
    flash[:danger] = 'Your article has been deleted'
    redirect_to articles_path
  end

  
  
  private
  
    def article_params
      params.require(:article).permit(:title, :description)
    end
    
    def find_article
      @article = Article.find(params[:id])
    end
end