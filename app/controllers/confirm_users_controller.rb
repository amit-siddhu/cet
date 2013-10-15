class ConfirmUsersController < ApplicationController

	def create
		@confirm_user = ConfirmUser.new(params[:confirm_user])
		    	respond_to do |format|
      		if ConfirmUser.find_by_email(@confirm_user.email).nil? || !(ConfirmUser.find_by_email(@confirm_user.email).status) || ConfirmUser.find_by_email(@confirm_user.email).status.nil?
            @confirm_user.confirm_token = SecureRandom.hex(64)
            @confirm_user.status = false
            if @confirm_user.save
        		  UserMailer.confirmation_email(@confirm_user).deliver
        		  format.html { redirect_to signup_path, notice: 'Please Check your email for account confirmation link.' }
        		  format.json { render json: @confirm_user, status: :created, location: @confirm_user }
      		  else
              format.html { redirect_to signup_path, notice: 'Sorry something went wrong. Please try again.' }
        		  #format.html { render action: "create" }
        		  format.json { render json: @confirm_user.errors, status: :unprocessable_entity }
            end
          else
              format.html { redirect_to signup_path, notice: 'This email id is already Registered. Please try again with different email id.' }
              #format.html { render action: "create" }
              format.json { render json: @confirm_user.errors, status: :unprocessable_entity }
      		end
    	end
	end

	def show

	 redirect_to root_path
		
	end
  def index
    redirect_to root_path
  end
end
