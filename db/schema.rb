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

ActiveRecord::Schema.define(:version => 20120722113437) do

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
    t.date     "date"
    t.string   "department"
    t.string   "name"
    t.string   "project"
    t.string   "function"
    t.decimal  "actual"
    t.decimal  "forecast"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "team"
  end

  create_table "tasks", :force => true do |t|
    t.integer   "requester_id"
    t.integer   "assignee_id"
    t.string    "taskname"
    t.date      "scd"
    t.date      "acd"
    t.integer   "priority"
    t.integer   "category"
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.boolean   "complete"
    t.date      "tcd"
    t.text      "description"
    t.string    "operation"
    t.boolean   "accepted"
    t.string    "device"
    t.string    "platform"
    t.integer   "duration"
    t.string    "family"
  end

  create_table "test_progs", :force => true do |t|
    t.string   "engineer"
    t.string   "status"
    t.string   "prog_name"
    t.string   "operation"
    t.string   "date_received"
    t.string   "comments"
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
  end

end
