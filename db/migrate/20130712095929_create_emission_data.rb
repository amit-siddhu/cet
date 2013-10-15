class CreateEmissionData < ActiveRecord::Migration
  def change
    create_table :emission_data do |t|
      t.string :bts
      t.string :power_consumption
      t.string :avg_grid_supply
      t.string :dg_capacity
      t.string :avg_dg_supply
      t.string :generator_efficiency
      t.string :creater

      t.timestamps
    end
  end
end
