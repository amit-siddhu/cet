class ConfirmUser < ActiveRecord::Base
  attr_accessible :company_name, :confirm_token, :email, :status
end
