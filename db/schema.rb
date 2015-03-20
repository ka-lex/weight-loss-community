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

ActiveRecord::Schema.define(:version => 20130501195121) do

  create_table "accounts", :force => true do |t|
    t.integer  "zipcode"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "age"
    t.string   "sex"
    t.integer  "size"
  end

  create_table "active_admin_comments", :force => true do |t|
    t.integer  "resource_id",   :null => false
    t.string   "resource_type", :null => false
    t.integer  "author_id"
    t.string   "author_type"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "namespace"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], :name => "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], :name => "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], :name => "index_admin_notes_on_resource_type_and_resource_id"

  create_table "admin_users", :force => true do |t|
    t.string   "email",                               :default => "", :null => false
    t.string   "encrypted_password",   :limit => 128, :default => "", :null => false
    t.string   "password_salt",                       :default => "", :null => false
    t.string   "reset_password_token"
    t.string   "remember_token"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                       :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admin_users", ["email"], :name => "index_admin_users_on_email", :unique => true
  add_index "admin_users", ["reset_password_token"], :name => "index_admin_users_on_reset_password_token", :unique => true

  create_table "conversations", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "conversations_users", :id => false, :force => true do |t|
    t.integer "conversation_id"
    t.integer "user_id"
  end

  create_table "friendships", :force => true do |t|
    t.integer "user_id"
    t.integer "friend_id"
    t.integer "blocker_id"
    t.boolean "pending",    :default => true
  end

  add_index "friendships", ["user_id", "friend_id"], :name => "index_friendships_on_user_id_and_friend_id", :unique => true

  create_table "group_comments", :force => true do |t|
    t.text     "content"
    t.integer  "group_member_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "group_members", :force => true do |t|
    t.integer  "user_id"
    t.integer  "group_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "group_members", ["created_at", "user_id"], :name => "index_group_members_on_created_at_and_user_id"
  add_index "group_members", ["user_id"], :name => "index_group_members_on_user_id"

  create_table "groups", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "groups_users", :force => true do |t|
    t.integer  "group_id",   :null => false
    t.integer  "user_id",    :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "messages", :force => true do |t|
    t.integer  "from_user_id"
    t.integer  "to_user_id"
    t.text     "body"
    t.string   "subject"
    t.string   "type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "conversation_id"
  end

  add_index "messages", ["created_at", "from_user_id"], :name => "index_messages_on_created_at_and_from_user_id"
  add_index "messages", ["created_at", "to_user_id"], :name => "index_messages_on_created_at_and_to_user_id"
  add_index "messages", ["from_user_id"], :name => "index_messages_on_from_user_id"
  add_index "messages", ["to_user_id"], :name => "index_messages_on_to_user_id"

  create_table "settings", :force => true do |t|
    t.integer  "user_id"
    t.boolean  "show_page"
    t.boolean  "show_weight"
    t.boolean  "show_target"
    t.boolean  "show_weight_loss"
    t.boolean  "show_chart"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "slugs", :force => true do |t|
    t.string   "name"
    t.integer  "sluggable_id"
    t.integer  "sequence",                     :default => 1, :null => false
    t.string   "sluggable_type", :limit => 40
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "slugs", ["name", "sluggable_type", "sequence", "scope"], :name => "index_slugs_on_n_s_s_and_s", :unique => true
  add_index "slugs", ["sluggable_id"], :name => "index_slugs_on_sluggable_id"

  create_table "subscriptions", :force => true do |t|
    t.integer  "account_id"
    t.string   "plan_name"
    t.date     "next_renewal_at"
    t.boolean  "auto_recurring"
    t.string   "psp_reference"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "suggestions", :force => true do |t|
    t.text     "text"
    t.integer  "creator_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug"
  end

  create_table "targets", :force => true do |t|
    t.string   "title"
    t.integer  "value"
    t.text     "description"
    t.date     "end_date"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "status"
  end

  add_index "targets", ["created_at", "user_id"], :name => "index_targets_on_created_at_and_user_id"
  add_index "targets", ["user_id"], :name => "index_targets_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "email",                                 :default => "", :null => false
    t.string   "encrypted_password",     :limit => 128, :default => ""
    t.string   "password_salt",                         :default => ""
    t.string   "reset_password_token"
    t.string   "remember_token"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "invitation_token",       :limit => 20
    t.datetime "invitation_sent_at"
    t.string   "username"
    t.boolean  "accepted_term"
    t.integer  "age"
    t.string   "sex"
    t.integer  "size"
    t.string   "slug"
    t.datetime "reset_password_sent_at"
  end

  add_index "users", ["confirmation_token"], :name => "index_users_on_confirmation_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["invitation_token"], :name => "index_users_on_invitation_token"
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "votings", :force => true do |t|
    t.string   "vote"
    t.integer  "user_id"
    t.integer  "suggestion_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "weights", :force => true do |t|
    t.integer  "user_id"
    t.integer  "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "weights", ["created_at", "user_id"], :name => "index_weights_on_created_at_and_user_id"
  add_index "weights", ["user_id"], :name => "index_weights_on_user_id"

end
