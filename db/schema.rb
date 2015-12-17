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

ActiveRecord::Schema.define(:version => 20151217111950) do

  create_table "can_mains", :force => true do |t|
    t.string    "can"
    t.boolean   "internal"
    t.boolean   "sort"
    t.boolean   "mark"
    t.boolean   "ft"
    t.boolean   "assy_loc"
    t.boolean   "device_tab"
    t.boolean   "inactive"
    t.string    "customer"
    t.string    "interface"
    t.string    "mfg_id"
    t.string    "i2w_addr"
    t.text      "comments"
    t.string    "fw_version"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "can_masters", :force => true do |t|
    t.string    "can"
    t.boolean   "internal"
    t.boolean   "sort"
    t.boolean   "mark"
    t.boolean   "ft"
    t.boolean   "assy_loc"
    t.boolean   "device_tab"
    t.boolean   "inactive"
    t.string    "customer"
    t.string    "interface"
    t.string    "mfg_id"
    t.string    "i2w_addr"
    t.text      "comments"
    t.string    "fw_version"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "can_subs", :force => true do |t|
    t.integer   "can_main_id"
    t.string    "cpn"
    t.string    "mpn"
    t.string    "package"
    t.text      "comment"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "costings", :force => true do |t|
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.string    "device"
    t.string    "pc"
    t.string    "rfwafer"
    t.string    "wafer"
    t.string    "probemat"
    t.string    "plant"
    t.string    "pohgroup"
    t.string    "asmmat"
    t.string    "asmohgroup"
    t.string    "asminforec"
    t.string    "tsmat"
    t.string    "tsohgroup"
    t.string    "tstinforec"
    t.string    "fginforec"
    t.float     "rwcost"
    t.float     "wafercost"
    t.float     "pcostwafer"
    t.integer   "grossdie"
    t.float     "sortyield"
    t.integer   "netgooddie"
    t.float     "probe_time"
    t.float     "probe_overhead"
    t.float     "diecost"
    t.float     "asm_ohcost"
    t.float     "asm_subcon"
    t.float     "asm_yield"
    t.float     "asm_cost"
    t.float     "tst_ohcost"
    t.float     "tst_subcon"
    t.float     "tst_yield"
    t.float     "tst_cost"
    t.float     "fg_subcon"
    t.float     "fg_yield"
    t.float     "fg_stdcost"
  end

  create_table "devices", :force => true do |t|
    t.string    "name"
    t.string    "friendly"
    t.integer   "gdpw"
    t.string    "productline"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "manids", :force => true do |t|
    t.string   "device"
    t.string   "customer"
    t.string   "products"
    t.string   "can_id"
    t.string   "mfgid"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "protocol"
    t.string   "cpn"
  end

  create_table "projects", :force => true do |t|
    t.string    "project"
    t.boolean   "key"
    t.date      "tapeout"
    t.date      "dr1"
    t.date      "dr2"
    t.date      "dr3"
    t.date      "dr4"
    t.date      "dr5"
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.string    "owner"
    t.string    "long_name"
  end

  create_table "ptos", :force => true do |t|
    t.integer   "user_id"
    t.date      "start"
    t.date      "finish"
    t.string    "comments"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "resources", :force => true do |t|
    t.date      "date"
    t.string    "department"
    t.string    "name"
    t.string    "project"
    t.string    "function"
    t.decimal   "actual"
    t.decimal   "forecast"
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.string    "team"
    t.string    "product_line"
  end

  create_table "samples", :force => true do |t|
    t.integer  "manid_id"
    t.date     "dateExchange"
    t.date     "dateSamples"
    t.date     "dateCustApproval"
    t.date     "dateQAEnable"
    t.date     "dateReleaseProduction"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "crs"
  end

  create_table "sas", :force => true do |t|
    t.string   "lot_number"
    t.string   "location"
    t.string   "plant"
    t.string   "profit_center"
    t.string   "sap_matid"
    t.string   "lts_matid"
    t.integer  "quantity"
    t.float    "standard_cost"
    t.float    "total"
    t.datetime "date"
    t.float    "reserve"
    t.string   "rma"
    t.string   "customer_number"
    t.string   "customer_details"
    t.float    "total_std_cost"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "sas_type"
    t.boolean  "sent"
    t.text     "comment"
    t.integer  "user_id"
    t.string   "owner"
  end

  create_table "setups", :force => true do |t|
    t.string   "location"
    t.string   "family"
    t.string   "device"
    t.string   "tab"
    t.string   "platform"
    t.string   "cp1"
    t.string   "cp2"
    t.string   "cp3"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "cp1_match_flag"
    t.integer  "cp2_match_flag"
    t.integer  "cp3_match_flag"
    t.string   "parallelism"
    t.string   "vendor"
  end

  create_table "targets", :force => true do |t|
    t.string   "family"
    t.string   "device"
    t.string   "tab"
    t.string   "mag_cp1"
    t.string   "mag_cp2"
    t.string   "mag_x64_cp1"
    t.string   "mag_x64_cp2"
    t.string   "mav_cp1"
    t.string   "mav_cp2"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "mag_cp3"
    t.string   "mag_x64_cp3"
    t.string   "mav_cp3"
    t.boolean  "cr3"
  end

  create_table "task_logs", :force => true do |t|
    t.text     "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "task_id"
  end

  create_table "tasks", :force => true do |t|
    t.integer  "requester_id"
    t.integer  "assignee_id"
    t.string   "taskname"
    t.date     "scd"
    t.date     "acd"
    t.integer  "priority"
    t.integer  "category"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "complete"
    t.date     "tcd"
    t.text     "description"
    t.string   "operation"
    t.boolean  "accepted"
    t.string   "device"
    t.string   "platform"
    t.integer  "duration"
    t.string   "family"
    t.string   "request_type"
  end

  create_table "test_progs", :force => true do |t|
    t.string   "engineer"
    t.string   "status"
    t.string   "prog_name"
    t.string   "operation"
    t.date     "date_received", :limit => 255
    t.string   "comments"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "crs_number"
  end

  create_table "test_times", :force => true do |t|
    t.integer  "device_id"
    t.string   "paralllelism"
    t.integer  "time"
    t.string   "operation"
    t.date     "date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string    "fullname"
    t.string    "name"
    t.string    "hashed_password"
    t.string    "salt"
    t.string    "department"
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.string    "email"
    t.integer   "auth_level"
    t.date      "passport"
    t.string    "team"
  end

end
