class SessionController < ApplicationController
  def create
    auth = request.env["omniauth.auth"]
    user = User.find_by_uid_and_provider(auth[:uid],auth[:provider]) || User.create_with_omniauth(auth)
    session[:user_id] = user.id

    unless session[:return_to].nil?
      redirect_to session[:return_to]
      session[:return_to] = nil
    else
      redirect_to root_url
    end
  end

  def destroy 
    session[:user_id] = nil;
    redirect_to root_url
  end

  def failure
    session[:user_id] = nil;
    redirect_to root_url
  end
end
