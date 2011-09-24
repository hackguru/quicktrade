class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.boolean :isSell
      t.string :title
      t.text :description
      t.float :price, :precision => 10, :scale => 2
      t.column :qty, 'integer unsigned'      
      t.decimal :southwestLat, :precision => 10
      t.decimal :northeastLng, :percision => 10
      t.references :user

      t.timestamps
    end
    add_index :orders, :user_id
  end
end
