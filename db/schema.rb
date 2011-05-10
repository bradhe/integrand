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

ActiveRecord::Schema.define(:version => 20110508173058) do

  create_table "builds", :force => true do |t|
    t.integer  "integration_id"
    t.string   "commit_id"
    t.string   "status"
    t.datetime "started_at"
    t.datetime "ended_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "integrations", :force => true do |t|
    t.string   "name"
    t.string   "repository"
    t.text     "prebuild_command", :default => "rake db:test:prepare"
    t.text     "build_command",    :default => "rake spec"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
