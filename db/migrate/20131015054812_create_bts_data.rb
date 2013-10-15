class CreateBtsData < ActiveRecord::Migration
  def change
    create_table :bts_data do |t|
      t.string :carbon_footprint
      t.string :carbon_footprint_opco
      t.string :days_in_month
      t.string :dg_capacity
      t.string :dg_closing_reading
      t.string :dg_opening_reading
      t.string :dg_rating
      t.string :dg_run_per_day
      t.string :eb_availability
      t.string :eb_closing_reading
      t.string :eb_opening_reading
      t.string :eb_rate_per_unit
      t.string :eb_status
      t.string :eb_units_consumption
      t.string :eta
      t.string :fuel_rate_per_ltr
      t.string :invoice_from
      t.string :invoice_month
      t.string :invoice_to
      t.string :ip_name
      t.string :ip_site_id
      t.string :kw_per_day
      t.string :opco_dc_load
      t.string :opco_diesel_amount
      t.string :opco_eb_cost
      t.string :opco_kwh
      t.string :opco_load_percent
      t.string :site_category
      t.string :site_name
      t.string :tenents_per_ip
      t.string :total_dg_run
      t.string :total_diesel_consumption
      t.string :total_diesel_cost
      t.string :total_eb_cost
      t.string :total_kwh_reading
      t.string :total_site_dc_load
      t.string :creator

      t.timestamps
    end
  end
end
