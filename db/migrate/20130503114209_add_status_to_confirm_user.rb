class AddStatusToConfirmUser < ActiveRecord::Migration
  def change
    add_column :confirm_users, :status, :boolean
  end
end
