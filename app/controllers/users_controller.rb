class UsersController < ApplicationController
  before_action :find_user, only: [:edit, :update, :show, :destroy]
  
  
  def index
    @users = User.paginate(page: params[:page], per_page: 5)
    
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to the Omega Blog, #{@user.username}"
      redirect_to articles_path
    else
      flash[:danger] = "There was an error, please try again"
      render 'new'
    end
  end
  
  def show
    @user_articles = @user.articles.paginate(page: params[:page], per_page: 5)
  end
   
  
  def edit
  end

  def update
    if @user.update(user_params)
      flash[:success] = 'Your profile has been updated'
    else
      render 'edit'
    end
  end
  
  def destroy
    @user.destroy
  end
  
  
  private
  
    def user_params
      params.require(:user).permit(:username, :email, :password, :password_confirmation)
    end
    
    def find_user
      @user = User.find(params[:id])
    end
end