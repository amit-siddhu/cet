class CreateCircles < ActiveRecord::Migration
  def change
    create_table :circles do |t|
      t.string :name
      t.string :admin
      t.string :subscribers
      t.string :creater

      t.timestamps
    end
  end
end
