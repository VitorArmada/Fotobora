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

ActiveRecord::Schema.define(version: 20151127164650) do

  create_table "entities", force: true do |t|
    t.integer  "x1"
    t.integer  "x2"
    t.integer  "y1"
    t.integer  "y2"
    t.integer  "user_id"
    t.integer  "photo_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "entities", ["photo_id"], name: "index_entities_on_photo_id"
  add_index "entities", ["user_id"], name: "index_entities_on_user_id"

  create_table "entities_entitytypes", id: false, force: true do |t|
    t.integer "entity_id"
    t.integer "entitytype_id"
  end

  add_index "entities_entitytypes", ["entity_id"], name: "index_entities_entitytypes_on_entity_id"
  add_index "entities_entitytypes", ["entitytype_id"], name: "index_entities_entitytypes_on_entitytype_id"

  create_table "entitystories", force: true do |t|
    t.string   "title"
    t.text     "text"
    t.integer  "entity_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "entitystories", ["entity_id"], name: "index_entitystories_on_entity_id"
  add_index "entitystories", ["user_id"], name: "index_entitystories_on_user_id"

  create_table "entitystorycomments", force: true do |t|
    t.text     "text"
    t.integer  "entitystory_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "entitystorycomments", ["entitystory_id"], name: "index_entitystorycomments_on_entitystory_id"
  add_index "entitystorycomments", ["user_id"], name: "index_entitystorycomments_on_user_id"

  create_table "entitytypes", force: true do |t|
    t.string   "name"
    t.integer  "propertytype_id"
    t.integer  "entitytype_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "entitytypes", ["entitytype_id"], name: "index_entitytypes_on_entitytype_id"
  add_index "entitytypes", ["propertytype_id"], name: "index_entitytypes_on_propertytype_id"

  create_table "people", force: true do |t|
    t.string   "name"
    t.integer  "father_id"
    t.integer  "mother_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "people", ["father_id"], name: "index_people_on_father_id"
  add_index "people", ["mother_id"], name: "index_people_on_mother_id"
  add_index "people", ["user_id"], name: "index_people_on_user_id"

  create_table "photos", force: true do |t|
    t.string   "address"
    t.datetime "date"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "picture_file_name"
    t.string   "picture_content_type"
    t.integer  "picture_file_size"
    t.datetime "picture_updated_at"
  end

  add_index "photos", ["user_id"], name: "index_photos_on_user_id"

  create_table "photostories", force: true do |t|
    t.string   "title"
    t.text     "text"
    t.integer  "photo_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "photostories", ["photo_id"], name: "index_photostories_on_photo_id"
  add_index "photostories", ["user_id"], name: "index_photostories_on_user_id"

  create_table "photostorycomments", force: true do |t|
    t.text     "text"
    t.integer  "photostory_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "photostorycomments", ["photostory_id"], name: "index_photostorycomments_on_photostory_id"
  add_index "photostorycomments", ["user_id"], name: "index_photostorycomments_on_user_id"

  create_table "properties", force: true do |t|
    t.string   "value"
    t.integer  "certainty"
    t.integer  "entity_id"
    t.integer  "propertytype_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "properties", ["entity_id"], name: "index_properties_on_entity_id"
  add_index "properties", ["propertytype_id"], name: "index_properties_on_propertytype_id"

  create_table "propertytypes", force: true do |t|
    t.string   "name"
    t.integer  "entitytype_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "propertytypes", ["entitytype_id"], name: "index_propertytypes_on_entitytype_id"

  create_table "requests", force: true do |t|
    t.string   "title"
    t.text     "text"
    t.datetime "date"
    t.integer  "photo_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "requests", ["photo_id"], name: "index_requests_on_photo_id"
  add_index "requests", ["user_id"], name: "index_requests_on_user_id"

  create_table "users", force: true do |t|
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
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "picture_file_name"
    t.string   "picture_content_type"
    t.integer  "picture_file_size"
    t.datetime "picture_updated_at"
    t.string   "gentree_file_name"
    t.string   "gentree_content_type"
    t.integer  "gentree_file_size"
    t.datetime "gentree_updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

  create_table "votes", force: true do |t|
    t.integer  "property_id"
    t.integer  "user_id"
    t.integer  "certainty"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "votes", ["property_id"], name: "index_votes_on_property_id"
  add_index "votes", ["user_id"], name: "index_votes_on_user_id"

  create_table "votetypes", force: true do |t|
    t.integer  "entity_id"
    t.integer  "user_id"
    t.integer  "entitytype_id"
    t.integer  "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "votetypes", ["entity_id"], name: "index_votetypes_on_entity_id"
  add_index "votetypes", ["entitytype_id"], name: "index_votetypes_on_entitytype_id"
  add_index "votetypes", ["user_id"], name: "index_votetypes_on_user_id"

end
