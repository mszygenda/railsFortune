class SessionController < ApplicationController
  def create
    auth = request.env["omniauth.auth"]
    user = User.find_by_uid_and_provider(auth[:uid],auth[:provider]) || User.create_with_omniauth(auth)
    session[:user_id] = user.id
    redirect_to root_url
  end
end
