class ArticlesController < ApplicationController
  before_action :find_article, only: [:show, :edit, :update, :destroy]
  before_action :require_user, except: [:index, :show]
  before_action :require_same_user, only: [:edit, :update, :destroy]
  
  def index
    @articles = Article.paginate(page: params[:page], per_page: 10).order(created_at: :desc)
    
  end
  
  def new
    @article = Article.new
  end
  
  def create
    @article = Article.new(article_params)
    @article.user = current_user
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
      params.require(:article).permit(:title, :description, category_ids: [])
    end
    
    def find_article
      @article = Article.find(params[:id])
    end
    
    def require_same_user
      if current_user != @article.user && !current_user.admin?
        flash[:danger] = "You can only perform this action on your own articles"
        redirect_to root_path
      end
    end
end