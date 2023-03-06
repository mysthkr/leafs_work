class UsersController < ApplicationController
  skip_before_action :login_required, only: [:new, :create]
  
  def new
    unless current_user then
      @user = User.new
    else
      redirect_to tasks_path, notice: "既にログインしています！"
    end
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to tasks_path
    else
      render :new
    end
  end
  
  def index
    @users = User.all
  end
  
  def show
    @user = User.find_by(id: params[:id])
    if @user == nil
      redirect_to tasks_path
    elsif @user.id == current_user.id
      @tasks = Task.all.where(user_id: @user.id).includes(:user).page(params[:page])
    else
      redirect_to tasks_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation)
  end
end
