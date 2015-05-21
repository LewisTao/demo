class AddUserIdToStores < ActiveRecord::Migration
  def change
    add_column :stores, :user_id, :integer
    add_index :stores, :user_id
  end
end
