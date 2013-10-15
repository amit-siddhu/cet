class EmissionData < ActiveRecord::Base
  attr_accessible :avg_dg_supply, :avg_grid_supply, :bts, :creater, :dg_capacity, :generator_efficiency, :power_consumption

def self.myimport(file)  
  CSV.foreach(file.path, headers: true) do |row|  
    EmissionData.create! row.to_hash  
  end  
end

end
