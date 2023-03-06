module SessionsHelper
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end
  
  def current_admin_user
    @current_admin_user ||= User.find_by(id: session[:user_id]).admin
  end
  
  def logged_in?
    current_user.present?
  end
end
