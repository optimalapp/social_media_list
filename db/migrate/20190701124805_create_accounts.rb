class CreateAccounts < ActiveRecord::Migration[5.2]
  def change
    create_table :accounts do |t|
      t.string :social_network
      t.belongs_to :user, index: true

      t.timestamps
    end
  end
end
