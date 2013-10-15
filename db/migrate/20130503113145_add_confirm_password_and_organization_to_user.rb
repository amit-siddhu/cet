class AddConfirmPasswordAndOrganizationToUser < ActiveRecord::Migration
  def change
    add_column :users, :confirm_password, :string
    add_column :users, :organization, :string
  end
end
