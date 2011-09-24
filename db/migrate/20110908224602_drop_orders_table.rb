class DropOrdersTable < ActiveRecord::Migration
  def up
    drop_table :orders
  end

  def down
  end
end
