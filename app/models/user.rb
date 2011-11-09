class User < ActiveRecord::Base
  acts_as_voter

  def self.create_with_omniauth auth
    create! do |user|
      user.uid = auth[:uid]
      if(!auth[:info].nil?)
        user.name = auth[:info][:name] #auth[:user_info][:name] 
      end
      user.provider = auth[:provider]
    end
  end
end
