class CreateListsAndUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.timestamps
    end

    create_table :lists do |t|
      t.string :name
      t.timestamps
    end

    create_table :lists_users, id: false do |t|
      t.belongs_to :user, index: true
      t.belongs_to :list, index: true
    end
  end
end
