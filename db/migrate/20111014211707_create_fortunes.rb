class CreateFortunes < ActiveRecord::Migration
  def change
    create_table :fortunes do |t|
      t.text :content
      t.string :author

      t.timestamps
    end
  end
end
