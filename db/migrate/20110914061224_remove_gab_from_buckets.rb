class RemoveGabFromBuckets < ActiveRecord::Migration
  def up
    remove_column :buckets, :gab
  end

  def down
    add_column :buckets, :gab, :decimal
  end
end
