class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.datetime :date_posted
      t.string :link
      t.belongs_to :account

      t.timestamps
    end
  end
end
