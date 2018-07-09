class CategoriesController < ApplicationController
  before_action :require_admin, except: [:index, :show]
  before_action :find_category, only: [:edit, :show, :update, :destroy]
  
  def index
    @categories = Category.paginate(page: params[:page], per_page: 10).order('name ASC')
  end
  
  def new
    @category = Category.new
  end
  
  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:success] = 'Category has been created'
      redirect_to categories_path
    else
      render 'new'
    end
  end
  
  def edit
  end
  
  def update
    if @category.update(category_params)
      flash[:success] = 'Category has been updated'
      redirect_to category_path(@category)
    else
      render 'edit'
    end
  end
  
  def show
    @category = Category.find(params[:id])
    @category_articles = @category.articles.paginate(page: params[:page], per_page: 10)
  end
  
  def destroy
    @category.destroy
    flash[:danger] = "Your category was deleted"
    redirect_to categories_path
  end
  
  
  private
  
    def find_category
      @category = Category.find(params[:id])
    end
  
    def category_params
      params.require(:category).permit(:name)
    end
    
    def require_admin
      # if !logged_in? || current_user.admin? == false
      if !logged_in? || (logged_in? and !current_user.admin?)
        flash[:danger] = 'You must be logged in and be an admin to perform this action'
        redirect_to categories_path
      end
    end
end