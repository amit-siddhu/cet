class PasswordReset < ActiveRecord::Base
  attr_accessible :email, :status, :token
end
