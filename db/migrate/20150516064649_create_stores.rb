class CreateStores < ActiveRecord::Migration
  def change
    create_table :stores do |t|
      t.string :name
      t.text :address
      t.text :description
      t.text :open_time

      t.timestamps null: false
    end
  end
end
