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

ActiveRecord::Schema.define(version: 20140427191306) do

  create_table "academies", force: true do |t|
    t.string   "academy_encode"
    t.string   "academy_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "all_test_courses", force: true do |t|
    t.integer  "all_test_id"
    t.string   "course_encode"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "all_tests", force: true do |t|
    t.date     "test_date"
    t.date     "begin_date"
    t.date     "end_date"
    t.string   "description"
    t.string   "attachment"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "course_totals", force: true do |t|
    t.string   "course_encode"
    t.string   "course_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "professionals", force: true do |t|
    t.string   "professional_encode"
    t.string   "professional_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sign_ups", force: true do |t|
    t.string   "subject_1_encode"
    t.string   "subject_2_encode"
    t.string   "subject_3_encode"
    t.string   "subject_4_encode"
    t.string   "name"
    t.string   "gender"
    t.string   "student_no"
    t.string   "id_type"
    t.string   "id_number"
    t.string   "education_len"
    t.string   "education"
    t.string   "start_school"
    t.string   "grade"
    t.string   "academy_encode"
    t.string   "professional_encode"
    t.string   "class_name"
    t.string   "tel"
    t.string   "photo_url"
    t.integer  "all_test_id"
    t.boolean  "paid"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "students", force: true do |t|
    t.string   "student_no"
    t.string   "name"
    t.string   "grade"
    t.string   "id_number"
    t.string   "academy_encode"
    t.string   "professional_encode"
    t.string   "gender"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "encode"
    t.string   "name"
    t.string   "academy_encode"
    t.string   "password_digest"
    t.string   "remember_token"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "permission"
  end

end
