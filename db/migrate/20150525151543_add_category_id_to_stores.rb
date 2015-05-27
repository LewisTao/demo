class AddCategoryIdToStores < ActiveRecord::Migration
  def change
    add_column :stores, :category_id, :integer
    add_index :stores, :category_id
  end
end
