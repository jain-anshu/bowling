# frozen_string_literal: true

# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 20_230_413_024_322) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'frames', force: :cascade do |t|
    t.boolean 'is_last', default: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.integer 'game_id'
  end

  create_table 'games', force: :cascade do |t|
    t.integer 'final_score', default: 0
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'rolls', force: :cascade do |t|
    t.string 'value', null: false
    t.integer 'numeric_value', default: 0
    t.boolean 'pending1', default: false
    t.boolean 'pending2', default: false
    t.boolean 'is_last', default: false
    t.integer 'total', default: 0
    t.bigint 'frame_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['frame_id'], name: 'index_rolls_on_frame_id'
  end

  add_foreign_key 'rolls', 'frames'
end
