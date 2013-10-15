class CreateAnes < ActiveRecord::Migration
  def change
    create_table :anes do |t|
      t.string :name
      t.string :ane_id
      t.string :location
      t.string :incharge_name
      t.string :incharge_contact
      t.string :incharge_email
      t.string :circle
      t.string :cne
      t.string :creater

      t.timestamps
    end
  end
end
