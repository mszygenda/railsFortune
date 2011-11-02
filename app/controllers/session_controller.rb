class SessionController < ApplicationController
  def create 
    auth = request.env["omniauth.auth"].to_yaml
    user = User.find_by_uid_and_provider auth[:uid],auth[:provider] || User.create_with_omniauth auth
    
  end
end
