class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :login_required
  # before_action :basic_auth 
  include SessionsHelper
  

  private

  def login_required
    redirect_to new_session_path unless current_user
  end
  
  # def basic_auth
  #   authenticate_or_request_with_http_basic do |username, password|
  #     username == ENV['BASIC_AUTH_USER'] && password == ENV['BASIC_AUTH_PASSWORD']
  #   end
  # end
end
