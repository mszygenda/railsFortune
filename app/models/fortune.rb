class Fortune < ActiveRecord::Base
  has_many :comments, :dependent => :destroy
  validates :content, :presence => true, :length => { :minimum => 3 }
  validates :author, :presence => true, :length => { :minimum => 3 }
  paginates_per 4

  SummaryLength = 75

  def content_short
    if content.length > SummaryLength
      content.slice(0 ... SummaryLength) + "..."
    else
      content
    end
  end
  
  def latest_comments
    comments.order "created_at DESC"
  end


end
