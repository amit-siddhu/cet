class CreateTsps < ActiveRecord::Migration
  def change
    create_table :tsps do |t|
      t.string :name
      t.string :admin
      t.string :creater

      t.timestamps
    end
  end
end
