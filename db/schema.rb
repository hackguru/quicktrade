# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110914061245) do

  create_table "buckets", :force => true do |t|
    t.decimal  "lastPrice"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "gap",        :precision => 10, :scale => 2
  end

  create_table "buckets_orders", :id => false, :force => true do |t|
    t.integer  "bucket_id"
    t.integer  "order_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "buckets_orders", ["bucket_id"], :name => "index_buckets_orders_on_bucket_id"
  add_index "buckets_orders", ["order_id"], :name => "index_buckets_orders_on_order_id"

  create_table "orders", :force => true do |t|
    t.boolean  "isSell"
    t.string   "title"
    t.text     "description"
    t.float    "price"
    t.integer  "qty"
    t.decimal  "southwestLat", :precision => 10, :scale => 0
    t.decimal  "northeastLng"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "orders", ["user_id"], :name => "index_orders_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "email",                                 :default => "", :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
