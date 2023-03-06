class Admin::UsersController < ApplicationController
  skip_before_action :login_required, only: [:new, :create]
  before_action :admin_login_required
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  
  def new
    if current_admin_user then
      @user = User.new
    end
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_users_path
    else
      render :new
    end
  end
  
  def index
    @users = User.all.page(params[:page])
  end
  
  def show
    @tasks = Task.all.where(user_id: @user.id).includes(:user).page(params[:page])
  end
  
  def edit
  end
  
  def update
    if @user.update(user_params)
      redirect_to admin_users_path, notice: "ユーザを編集しました！"
    else
        render :edit
    end
  end
  
  def destroy
    @user.destroy
    redirect_to admin_users_path, notice: "ユーザを削除しました！"
  end
  
  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :admin,
                                 :password_confirmation )
  end
  
  def set_user
    @user = User.find(params[:id])
  end
end
