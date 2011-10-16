class Fortune < ActiveRecord::Base
  has_many :comments

  SummaryLength = 75

  def content_short
    if content.length > SummaryLength
      content.slice(0 ... SummaryLength) + "..."
    else
      content
    end
  end

end
