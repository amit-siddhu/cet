class CreateFormulas < ActiveRecord::Migration
  def change
    create_table :formulas do |t|
      t.string :name
      t.string :formula
      t.string :creator

      t.timestamps
    end
  end
end
