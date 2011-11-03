class User < ActiveRecord::Base
  acts_as_voter

  def self.create_with_omniauth auth
    create! do |user|
      user.uid = auth[:uid]
      user.name = auth[:first_name] #auth[:user_info][:name] 
      user.provider = auth[:provider]
    end
  end
end
