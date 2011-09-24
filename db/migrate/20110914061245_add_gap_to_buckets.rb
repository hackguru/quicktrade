class AddGapToBuckets < ActiveRecord::Migration
  def change
    add_column :buckets, :gap, :decimal, :precision => 10, :scale => 2
  end
end
