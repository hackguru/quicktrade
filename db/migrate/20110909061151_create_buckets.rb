class CreateBuckets < ActiveRecord::Migration
  def change
    create_table :buckets do |t|
      t.decimal :gab, :precision => 10, :scale => 2
      t.decimal :lastPrice, :precision => 10, :scale => 2

      t.timestamps
    end
  end
end
