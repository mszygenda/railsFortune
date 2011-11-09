class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user
  
  private

  def authenticate 
    if current_user.nil?
      session[:return_to] = request.url
      redirect_to '/auth/github'
    end
  end
  
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
end
