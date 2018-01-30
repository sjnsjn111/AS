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

ActiveRecord::Schema.define(version: 20180128135826) do

  create_table "activities", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "trackable_type"
    t.bigint "trackable_id"
    t.string "owner_type"
    t.bigint "owner_id"
    t.string "key"
    t.text "parameters"
    t.string "recipient_type"
    t.bigint "recipient_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["owner_id", "owner_type"], name: "index_activities_on_owner_id_and_owner_type"
    t.index ["owner_type", "owner_id"], name: "index_activities_on_owner_type_and_owner_id"
    t.index ["recipient_id", "recipient_type"], name: "index_activities_on_recipient_id_and_recipient_type"
    t.index ["recipient_type", "recipient_id"], name: "index_activities_on_recipient_type_and_recipient_id"
    t.index ["trackable_id", "trackable_type"], name: "index_activities_on_trackable_id_and_trackable_type"
    t.index ["trackable_type", "trackable_id"], name: "index_activities_on_trackable_type_and_trackable_id"
  end

  create_table "departments", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.text "school_id"
    t.date "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_departments_on_name"
  end

  create_table "major_departments", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "major_id"
    t.bigint "department_id"
    t.date "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["department_id"], name: "index_major_departments_on_department_id"
    t.index ["major_id", "department_id"], name: "index_major_departments_on_major_id_and_department_id"
    t.index ["major_id"], name: "index_major_departments_on_major_id"
  end

  create_table "majors", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "school_id"
    t.string "name"
    t.string "code"
    t.text "introducing"
    t.date "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name", "code"], name: "index_majors_on_name_and_code"
    t.index ["school_id"], name: "index_majors_on_school_id"
  end

  create_table "notes", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.date "start_time"
    t.date "end_time"
    t.text "content"
    t.date "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "notifications", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "user_id"
    t.string "event_type"
    t.bigint "event_id"
    t.text "content"
    t.text "user_read"
    t.text "user_readed"
    t.date "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_type", "event_id"], name: "index_notifications_on_event_type_and_event_id"
    t.index ["user_id"], name: "index_notifications_on_user_id"
  end

  create_table "registers", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "major_id"
    t.bigint "user_id"
    t.bigint "department_id"
    t.integer "aspiration"
    t.boolean "status", default: false
    t.date "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["department_id"], name: "index_registers_on_department_id"
    t.index ["major_id"], name: "index_registers_on_major_id"
    t.index ["user_id"], name: "index_registers_on_user_id"
  end

  create_table "remarkings", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "result_id"
    t.bigint "school_id"
    t.integer "status", default: 0
    t.text "content"
    t.date "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["result_id", "status"], name: "index_remarkings_on_result_id_and_status"
    t.index ["result_id"], name: "index_remarkings_on_result_id"
    t.index ["school_id"], name: "index_remarkings_on_school_id"
  end

  create_table "results", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "user_id"
    t.bigint "subject_id"
    t.float "mark", limit: 24
    t.date "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["subject_id"], name: "index_results_on_subject_id"
    t.index ["user_id"], name: "index_results_on_user_id"
  end

  create_table "reviews", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "major_id"
    t.float "amount", limit: 24
    t.date "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["major_id", "created_at"], name: "index_reviews_on_major_id_and_created_at"
    t.index ["major_id"], name: "index_reviews_on_major_id"
  end

  create_table "schools", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.text "address"
    t.string "phone"
    t.string "email"
    t.string "code"
    t.string "logo"
    t.text "url_school"
    t.text "introducing"
    t.integer "level"
    t.date "deleted_at"
    t.string "city"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name", "level"], name: "index_schools_on_name_and_level"
  end

  create_table "subject_departments", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "subject_id"
    t.bigint "department_id"
    t.date "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["department_id"], name: "index_subject_departments_on_department_id"
    t.index ["subject_id", "department_id"], name: "index_subject_departments_on_subject_id_and_department_id", unique: true
    t.index ["subject_id"], name: "index_subject_departments_on_subject_id"
  end

  create_table "subjects", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.string "code"
    t.date "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name", "code"], name: "index_subjects_on_name_and_code"
  end

  create_table "targets", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "major_id"
    t.integer "amount"
    t.integer "year"
    t.date "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["major_id", "year"], name: "index_targets_on_major_id_and_year", unique: true
    t.index ["major_id"], name: "index_targets_on_major_id"
  end

  create_table "teachers", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "user_id"
    t.bigint "school_id"
    t.date "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["school_id"], name: "index_teachers_on_school_id"
    t.index ["user_id"], name: "index_teachers_on_user_id"
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.date "birthday"
    t.string "email"
    t.string "phone"
    t.text "address"
    t.integer "sex"
    t.string "people_id"
    t.integer "role", default: 0
    t.string "nation"
    t.string "nationality"
    t.text "avatar"
    t.integer "year"
    t.date "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["name", "role"], name: "index_users_on_name_and_role"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
  end

end
