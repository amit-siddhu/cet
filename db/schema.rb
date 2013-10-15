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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20131015054812) do

  create_table "anes", :force => true do |t|
    t.string   "name"
    t.string   "ane_id"
    t.string   "location"
    t.string   "incharge_name"
    t.string   "incharge_contact"
    t.string   "incharge_email"
    t.string   "circle"
    t.string   "cne"
    t.string   "creater"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "bts_data", :force => true do |t|
    t.string   "carbon_footprint"
    t.string   "carbon_footprint_opco"
    t.string   "days_in_month"
    t.string   "dg_capacity"
    t.string   "dg_closing_reading"
    t.string   "dg_opening_reading"
    t.string   "dg_rating"
    t.string   "dg_run_per_day"
    t.string   "eb_availability"
    t.string   "eb_closing_reading"
    t.string   "eb_opening_reading"
    t.string   "eb_rate_per_unit"
    t.string   "eb_status"
    t.string   "eb_units_consumption"
    t.string   "eta"
    t.string   "fuel_rate_per_ltr"
    t.string   "invoice_from"
    t.string   "invoice_month"
    t.string   "invoice_to"
    t.string   "ip_name"
    t.string   "ip_site_id"
    t.string   "kw_per_day"
    t.string   "opco_dc_load"
    t.string   "opco_diesel_amount"
    t.string   "opco_eb_cost"
    t.string   "opco_kwh"
    t.string   "opco_load_percent"
    t.string   "site_category"
    t.string   "site_name"
    t.string   "tenents_per_ip"
    t.string   "total_dg_run"
    t.string   "total_diesel_consumption"
    t.string   "total_diesel_cost"
    t.string   "total_eb_cost"
    t.string   "total_kwh_reading"
    t.string   "total_site_dc_load"
    t.string   "creator"
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
  end

  create_table "circles", :force => true do |t|
    t.string   "name"
    t.string   "admin"
    t.string   "subscribers"
    t.string   "creater"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "cnes", :force => true do |t|
    t.string   "name"
    t.string   "cne_id"
    t.string   "location"
    t.string   "incharge_name"
    t.string   "incharge_contact"
    t.string   "incharge_email"
    t.string   "circle"
    t.string   "creater"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "confirm_users", :force => true do |t|
    t.string   "email"
    t.string   "company_name"
    t.string   "confirm_token"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.boolean  "status"
  end

  create_table "emission_data", :force => true do |t|
    t.string   "bts"
    t.string   "power_consumption"
    t.string   "avg_grid_supply"
    t.string   "dg_capacity"
    t.string   "avg_dg_supply"
    t.string   "generator_efficiency"
    t.string   "creater"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
  end

  create_table "password_resets", :force => true do |t|
    t.string   "email"
    t.string   "token"
    t.boolean  "status"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "tsps", :force => true do |t|
    t.string   "name"
    t.string   "admin"
    t.string   "creater"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "password"
    t.string   "phone_number"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.string   "confirm_password"
    t.string   "organization"
  end

end
