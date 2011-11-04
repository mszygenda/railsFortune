class Comment < ActiveRecord::Base
  belongs_to :fortune
  belongs_to :user

  validates :content, :presence => true, :length => 3...250
  validates :author, :length => 3...50, :unless => :user_id?
  acts_as_voteable
end
