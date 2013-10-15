class User < ActiveRecord::Base
  attr_accessible :email, :first_name, :last_name, :password, :phone_number, :confirm_password, :organization	
end
