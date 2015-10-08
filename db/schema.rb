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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20151007180255) do

  create_table "addresses", force: :cascade do |t|
    t.string   "address1",                   null: false
    t.string   "address2"
    t.string   "city",                       null: false
    t.string   "state",            limit: 2, null: false
    t.string   "zip",                        null: false
    t.string   "home_phone"
    t.string   "cell_phone"
    t.integer  "addressable_id"
    t.string   "addressable_type"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "addresses", ["addressable_type", "addressable_id"], name: "index_addresses_on_addressable_type_and_addressable_id", unique: true

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "groups", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "owner_id"
    t.string   "avatar"
    t.boolean  "public",      default: false
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "groups", ["name"], name: "index_groups_on_name", unique: true

  create_table "invitations", force: :cascade do |t|
    t.integer  "sender_id"
    t.string   "recipient_email"
    t.string   "token"
    t.datetime "sent_at"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "group_id"
  end

  add_index "invitations", ["group_id"], name: "index_invitations_on_group_id"

  create_table "items", force: :cascade do |t|
    t.integer  "category_id"
    t.string   "name"
    t.text     "description"
    t.integer  "owner_id"
    t.string   "avatar"
    t.datetime "available_at"
    t.text     "comment"
    t.boolean  "available"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "memberships", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "group_id"
    t.boolean  "groupowner"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "invitation_id"
  end

  create_table "requests", force: :cascade do |t|
    t.integer  "requestor_id"
    t.datetime "requesting_at"
    t.datetime "returning_at"
    t.text     "description"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.integer  "item_id"
    t.boolean  "accepted",      default: false
  end

  add_index "requests", ["item_id"], name: "index_requests_on_item_id"
  add_index "requests", ["requestor_id"], name: "index_requests_on_requestor_id"

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

  create_table "wishitems", force: :cascade do |t|
    t.integer  "category_id"
    t.string   "name",          null: false
    t.text     "description"
    t.integer  "requestor_id"
    t.datetime "requesting_at"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "wishitems", ["category_id"], name: "index_wishitems_on_category_id"

end
