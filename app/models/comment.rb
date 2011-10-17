class Comment < ActiveRecord::Base
  belongs_to :fortune
  validates :content, :presence => true, :length => 3...250
  validates :author, :presence => true, :length => 3...50
end
