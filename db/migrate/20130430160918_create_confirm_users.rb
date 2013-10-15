class CreateConfirmUsers < ActiveRecord::Migration
  def change
    create_table :confirm_users do |t|
      t.string :email
      t.string :company_name
      t.string :confirm_token

      t.timestamps
    end
  end
end
