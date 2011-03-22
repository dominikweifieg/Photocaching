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

ActiveRecord::Schema.define(:version => 20110321082401) do

  create_table "flags", :force => true do |t|
    t.integer  "reason"
    t.integer  "photo_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pages", :force => true do |t|
    t.string   "title"
    t.string   "permalink"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "photos", :force => true do |t|
    t.integer  "user_id"
    t.string   "url"
    t.string   "thumb"
    t.float    "lat"
    t.float    "lng"
    t.string   "license"
    t.string   "title"
    t.boolean  "verified"
    t.integer  "inappropriate_count"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "flags_count"
  end

  create_table "plays", :force => true do |t|
    t.integer  "user_id"
    t.integer  "photo_id"
    t.integer  "radius"
    t.float    "lat"
    t.float    "lng"
    t.datetime "end_time"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "thumb"
    t.text     "url"
  end

  create_table "users", :force => true do |t|
    t.string   "alias"
    t.string   "identifier"
    t.string   "device"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "subscription_expires"
    t.string   "original_transaction_id"
    t.datetime "original_purchase_date"
    t.datetime "purchase_date"
    t.boolean  "subscription"
    t.text     "latest_receipt"
    t.string   "product_id"
  end

end
