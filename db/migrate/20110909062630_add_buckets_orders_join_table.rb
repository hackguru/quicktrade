class AddBucketsOrdersJoinTable < ActiveRecord::Migration
  def up
    create_table :buckets_orders, :id => false do |t|
      t.references :bucket
      t.references :order

    
      t.timestamps
    end
    add_index :buckets_orders, :bucket_id
    add_index :buckets_orders, :order_id
  end

  def down
    drop_table :buckets_orders
  end
end
