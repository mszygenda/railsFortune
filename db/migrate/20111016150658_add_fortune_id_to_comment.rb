class AddFortuneIdToComment < ActiveRecord::Migration
  def change
    add_column :comments, :fortune_id, :int
  end
end
