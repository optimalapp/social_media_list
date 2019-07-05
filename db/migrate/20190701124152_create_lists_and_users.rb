class CreateListsAndUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.timestamps
    end

    create_table :lists do |t|
      t.string :usr_ids, default: "/"
      t.string :name
      t.timestamps
    end

    create_table :lists_users do |t|
      t.integer :user_id
      t.integer :list_id
      t.belongs_to :user, index: true
      t.belongs_to :list, index: true
    end
  end
end
