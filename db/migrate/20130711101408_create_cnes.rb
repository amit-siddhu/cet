class CreateCnes < ActiveRecord::Migration
  def change
    create_table :cnes do |t|
      t.string :name
      t.string :cne_id
      t.string :location
      t.string :incharge_name
      t.string :incharge_contact
      t.string :incharge_email
      t.string :circle
      t.string :creater

      t.timestamps
    end
  end
end
