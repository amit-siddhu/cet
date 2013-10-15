class UserMailer < ActionMailer::Base
  default from: "amit.siddhu7@gmail.com"

	def confirmation_email(confirm_user)
		@confirm_user = confirm_user
		@url = "http://cet.herokuapp.com/registration?token=" + @confirm_user.confirm_token
		mail(:to => @confirm_user.email, :subject => "Welcome to I2TB-CET")	
	end

	def password_reset(user_detail)
		@user_detail=user_detail
		@url = "http://cet.herokuapp.com/password_reset?token="+ @user_detail.token
		mail(:to => @user_detail.email, :subject => "I2TB-CET account password reset link")
	end
end
