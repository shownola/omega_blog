class UsersController < ApplicationController
  before_action :find_user, only: [:edit, :update, :show, :destroy]
  before_action :require_same_user, only: [:edit, :update, :destroy]
  before_action :require_admin, only: [:destroy]
  
  
  def index
    @users = User.paginate(page: params[:page], per_page: 5)
    
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = "Welcome to the Omega Blog, #{@user.username}"
      redirect_to user_path(@user)
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
    flash[:danger] = "User and all articles created by that user have been deleted"
    redirect_to users_path
  end
  
  
  private
  
    def user_params
      params.require(:user).permit(:username, :email, :password, :password_confirmation)
    end
    
    def find_user
      @user = User.find(params[:id])
    end
    
    def require_same_user
      if current_user != @user and !current_user.admin?
        flash[:danger] = "You can only perform this action on your own account"
        redirect_to root_path
      end
    end
    
    def require_admin
      if logged_in? and current_user.admin? == false
        flash[:danger] = 'Only admin users can perform that action'
        redirect_to root_path
      end
    end
end

