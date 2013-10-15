class BtsData < ActiveRecord::Base
  attr_accessible :carbon_footprint, :carbon_footprint_opco, :creator, :days_in_month, :dg_capacity, :dg_closing_reading, :dg_opening_reading, :dg_rating, :dg_run_per_day, :eb_availability, :eb_closing_reading, :eb_opening_reading, :eb_rate_per_unit, :eb_status, :eb_units_consumption, :eta, :fuel_rate_per_ltr, :invoice_from, :invoice_month, :invoice_to, :ip_name, :ip_site_id, :kw_per_day, :opco_dc_load, :opco_diesel_amount, :opco_eb_cost, :opco_kwh, :opco_load_percent, :site_category, :site_name, :tenents_per_ip, :total_dg_run, :total_diesel_consumption, :total_diesel_cost, :total_eb_cost, :total_kwh_reading, :total_site_dc_load
end
