class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.text :text
      t.string :link
      t.datetime :date_posted
      t.belongs_to :account

      t.timestamps
    end
  end
end
