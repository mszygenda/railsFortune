module CommentsHelper
  def unique_field_id comment, field_name
    "comment_#{h field_name}_#{comment.fortune_id}"
  end
end
