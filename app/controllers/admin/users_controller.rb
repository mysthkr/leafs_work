class Admin::UsersController < ApplicationController
  skip_before_action :login_required, only: [:new, :create]
  before_action :admin_login_required
  
  def new
    if current_admin_user_auth then
      @user = User.new
    end
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_users_path
    else
      render :admin_new
    end
  end
  
  def index
    @users = User.all.page(params[:page])
  end
  
  def show
    @user = User.find(params[:id])
    @tasks = Task.all.where(id: @user.id).includes(:user).page(params[:page])
  end
  
  private

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation, :admin)
  end
end
