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

ActiveRecord::Schema.define(version: 20170214075048) do

  create_table "authors", force: :cascade do |t|
    t.string   "name"
    t.string   "gender"
    t.string   "address"
    t.string   "description"
    t.integer  "publisher_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "image"
  end

  create_table "books", force: :cascade do |t|
    t.string   "name"
    t.date     "publisher_year"
    t.integer  "amount"
    t.integer  "weight"
    t.string   "language"
    t.string   "description"
    t.float    "rating"
    t.integer  "publisher_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.string   "image"
  end

  create_table "borrow_books", force: :cascade do |t|
    t.date     "date_borrow"
    t.date     "date_return"
    t.integer  "user_id"
    t.integer  "book_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["book_id"], name: "index_borrow_books_on_book_id"
    t.index ["user_id"], name: "index_borrow_books_on_user_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "comments", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "book_id"
    t.string   "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["book_id"], name: "index_comments_on_book_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "publishers", force: :cascade do |t|
    t.string   "name"
    t.string   "address"
    t.integer  "phone"
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "ratings", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "book_id"
    t.integer  "rate"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["book_id"], name: "index_ratings_on_book_id"
    t.index ["user_id"], name: "index_ratings_on_user_id"
  end

  create_table "relationships", force: :cascade do |t|
    t.integer  "ownerable_id"
    t.string   "ownerable_type"
    t.integer  "targetable_id"
    t.string   "targetable_type"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email"
    t.string   "password_digest"
    t.string   "address"
    t.string   "name"
    t.integer  "phonenumber"
    t.boolean  "is_admin",        default: false
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "remember_digest"
    t.string   "image"
  end

end
