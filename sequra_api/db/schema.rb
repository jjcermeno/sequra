# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_03_07_191701) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "disbursements", force: :cascade do |t|
    t.bigint "merchant_id"
    t.integer "week"
    t.integer "year"
    t.decimal "total_amount"
    t.decimal "total_fee"
    t.decimal "total_disbursement"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["merchant_id"], name: "index_disbursements_on_merchant_id"
  end

  create_table "merchants", force: :cascade do |t|
    t.integer "merchant_id"
    t.string "name"
    t.string "email"
    t.string "cif"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["merchant_id"], name: "index_merchants_on_merchant_id"
  end

  create_table "orders", force: :cascade do |t|
    t.bigint "disbursement_id"
    t.bigint "merchant_id"
    t.bigint "shopper_id"
    t.integer "order_id"
    t.integer "ext_merchant_id"
    t.integer "ext_shopper_id"
    t.decimal "amount", default: "0.0"
    t.decimal "fee", default: "0.0"
    t.decimal "disbursement", default: "0.0"
    t.datetime "completed_at"
    t.boolean "completed", default: false
    t.integer "week"
    t.integer "year"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["disbursement_id"], name: "index_orders_on_disbursement_id"
    t.index ["merchant_id"], name: "index_orders_on_merchant_id"
    t.index ["order_id"], name: "index_orders_on_order_id"
    t.index ["shopper_id"], name: "index_orders_on_shopper_id"
  end

  create_table "shoppers", force: :cascade do |t|
    t.integer "shopper_id"
    t.string "name"
    t.string "email"
    t.string "nif"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["shopper_id"], name: "index_shoppers_on_shopper_id"
  end

end
