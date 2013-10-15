class UsersController < ApplicationController
  
  require 'rubygems'
  require 'roo'
  require 'fileutils'

  def index

    if session[:id].nil?
      
    

    if request.post?
      if !(params['recovery_mail'].nil?)
        if !(User.find_by_email(params['recovery_mail']).nil?)
          @reset=PasswordReset.new
          @reset.email=User.find_by_email(params['recovery_mail']).email
          @reset.token=SecureRandom.hex(64)
          @reset.status=false
          if @reset.save
            UserMailer.password_reset(@reset).deliver
            redirect_to root_path, notice: 'Please check your email for password reset link.'    
            
          else
            redirect_to root_path, notice: 'Error: Sorry but something went wrong.'      
          end
          

        else
          redirect_to root_path, notice: 'Error: This Email not found in our record.' 
        end              
            
      elsif params['login'].nil? || params['pass'].nil? || User.find_by_email(params[:login]).nil? || params[:pass]!=User.find_by_email(params[:login]).password
        redirect_to root_path, notice: 'Error: Invalid username and/or Password.'

      else
        session[:id]=User.find_by_email(params[:login]).id
        session[:email]=User.find_by_email(params[:login]).email
        redirect_to dashboard_path#, notice: "Welcome " + User.find_by_id(session[:id]).first_name + "." 
      end

    end


    else
      redirect_to dashboard_path
    end

  end

 def signup

    
  @confirm_user = ConfirmUser.new
  respond_to do |format|
      format.html # signup.html.erb
      format.json { render json: @user }
 
      end
     
     
 end

def registration
  if params[:token].nil?
    redirect_to signup_path, notice: 'You did not have any token. Please Signup.'
    
  elsif !(request.get?) || ConfirmUser.find_by_confirm_token(params[:token]).nil?
      redirect_to signup_path, notice: 'Invalid Token. Please signup to register.'
        
  elsif !(ConfirmUser.find_by_confirm_token(params[:token]).created_at < Time.now.getutc && Time.now.getutc <= (ConfirmUser.find_by_confirm_token(params[:token]).created_at + 24*60*60))
      redirect_to signup_path, notice: 'Token expired. Please Signup Again.'
      
  elsif ConfirmUser.find_by_confirm_token(params[:token]).status?
      redirect_to signup_path, notice: 'Token already used. Please signup again to register.'
      
  elsif !(User.find_by_email(ConfirmUser.find_by_confirm_token(params[:token]).email).nil?)
    redirect_to signup_path, notice: 'This email id already registerd. Please signup again with different email to register.'

  else
    @user = User.new
     session[:token] = params[:token]
    respond_to do |format|
    format.html # registration.html.erb
    format.json { render json: @user }
    
  end

end
end

def dashboard
  if session[:id].nil?

    redirect_to root_path, notice: 'Please Login to access your Dashboard.'
    
  else
    @user = User.find_by_id(session[:id])

  end
  
	
end

def create

	 @user = User.new(params[:user])

   @user.email = ConfirmUser.find_by_confirm_token(session[:token]).email
   @user.organization = ConfirmUser.find_by_confirm_token(session[:token]).company_name

    respond_to do |format|
      if @user.save
        @tmp=ConfirmUser.find_by_confirm_token(session[:token])
        @tmp.status=true
        @tmp.save
        reset_session
        #UserMailer.confirmation_email(@user).deliver
        format.html { redirect_to root_path, notice: 'You have been successfully registered. You can login Now.' }
        format.json { render json: @user, status: :created, location: @user }
      else
        reset_session
        format.html { redirect_to signup_path, notice: 'Sorry somethimg went wrong. Please try again'}
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
	
end

def confirm_user
   @confirm_user = ConfirmUser.new
  respond_to do |format|
      format.html # signup.html.erb
      format.json { render json: @user }
      end
  
end

def password_reset
  
  if params[:token].nil?
    redirect_to root_path, notice: 'You did not have any token.'
    
  elsif !(request.get?) || PasswordReset.find_by_token(params[:token]).nil?
      redirect_to root_path, notice: 'Invalid Token. Please provide a valid token to reset your password.'
        
  elsif !(PasswordReset.find_by_token(params[:token]).created_at < Time.now.getutc && Time.now.getutc <= (PasswordReset.find_by_token(params[:token]).created_at + 24*60*60))
      redirect_to root_path, notice: 'Token expired.'
      
  elsif PasswordReset.find_by_token(params[:token]).status?
      redirect_to root_path, notice: 'Token already used.'
      
  else
    session[:rtoken] = params[:token]    
    
  end

end

  def passreset

    if request.post? && !(session[:rtoken].nil?) && !(params[:newpass].nil?) && (params[:newpass] === params[:confirmpass])
        
      @change = User.find_by_email(PasswordReset.find_by_token(session[:rtoken]).email)
      @change.password = params[:newpass]
      @change.confirm_password = params[:confirmpass]
        if @change.save
        @st = PasswordReset.find_by_token(session[:rtoken])
        @st.status=true
        @st.save
        reset_session
        redirect_to root_path, notice: 'Your Password changed successfully.'
      else
        redirect_to root_path, notice: 'Sorry but something went wrong. Please try again.'
        reset_session  
      end

    else
       redirect_to root_path, notice: 'Error: Invalid request.'

    end
  end

  def show
    redirect_to root_path
    
  end

  def logout
    if !(reset_session)
      redirect_to root_path, notice: 'You have been successfully Logout.'

      else
      redirect_to root_path, notice: 'Error: Logout process failed, Please Re-login and Logout again.'      
    end
  end


 # def tsp
    
  #  @tsp = Tsp.new

  #end

   def create_tsp

    if Tsp.find_by_creater(session[:email]).nil?
      
    
   @tsp = Tsp.new
    
    respond_to do |format|
      format.html # signup.html.erb
      format.json { render json: @tsp }
    end

   # if request.post? && !params[:name].nil? && !params[:admin].nil?
  else
    redirect_to dashboard_path, notice: 'Error: You have already created a TSP.'

 end



   
  end 

  def tsp_created

     @tsp = Tsp.new(params[:tsp])
     @tsp.creater = session[:email]
   
    respond_to do |format|
      if @tsp.save
        format.html { redirect_to dashboard_path, notice: 'Notice: TSP created successfully.' }
        format.json { render json: @tsp, status: :created, location: @tsp }
      else
        format.html { redirect_to dashboard_path, notice: 'Error: Sorry somethimg went wrong. Please try again.'}
        format.json { render json: @tsp.errors, status: :unprocessable_entity }
      end
    end
    
  end

  def create_circle

    if Tsp.find_by_creater(session[:email]).nil?
      redirect_to dashboard_path, notice: 'Error: Create a TSP first.'
    else  
       @circle = Circle.new
    
      respond_to do |format|
      format.html # signup.html.erb
      format.json { render json: @circle }
    end

   # if request.post? && !params[:name].nil? && !params[:admin].nil?
  
    

 end



   
  end 

  def circle_created

     @circle = Circle.new(params[:circle])
     @circle.creater = session[:email]
   
    respond_to do |format|
      if @circle.save
        format.html { redirect_to dashboard_path, notice: 'Notice: Circle created successfully.' }
        format.json { render json: @circle, status: :created, location: @circle }
      else
        format.html { redirect_to dashboard_path, notice: 'Error: Sorry somethimg went wrong. Please try again.'}
        format.json { render json: @circle.errors, status: :unprocessable_entity }
      end
    end
    
  end




def create_cne

    if Tsp.find_by_creater(session[:email]).nil? && Circle.find_by_creater(session[:email]).nil?
      redirect_to dashboard_path, notice: 'Error: Create a TSP and atleast one circle first.'

      elsif Circle.find_by_creater(session[:email]).nil?
      redirect_to dashboard_path, notice: 'Error: Create atleast one circle first.'

    else  
       @cne = Cne.new

      @circle = Circle.find_all_by_creater(session[:email])

      respond_to do |format|
      format.html # signup.html.erb
      format.json { render json: @cne }
    end

   # if request.post? && !params[:name].nil? && !params[:admin].nil?
  
    

 end



   
  end 

  def cne_created

     @cne = Cne.new(params[:cne])
     @cne.creater = session[:email]
   
    respond_to do |format|
      if @cne.save
        format.html { redirect_to dashboard_path, notice: 'Notice: CNE created successfully.' }
        format.json { render json: @cne, status: :created, location: @cne }
      else
        format.html { redirect_to dashboard_path, notice: 'Error: Sorry somethimg went wrong. Please try again.'}
        format.json { render json: @cne.errors, status: :unprocessable_entity }
      end
    end
    
  end





  def create_ane

    if Tsp.find_by_creater(session[:email]).nil? && Circle.find_by_creater(session[:email]).nil?
      redirect_to dashboard_path, notice: 'Error: Create a TSP and atleast one circle first.'

      elsif Circle.find_by_creater(session[:email]).nil?
      redirect_to dashboard_path, notice: 'Error: Create atleast one circle first.'

    else  
       @ane = Ane.new

       @circle = Circle.find_all_by_creater(session[:email])
    
      respond_to do |format|
      format.html # signup.html.erb
      format.json { render json: @ane }
    end

   # if request.post? && !params[:name].nil? && !params[:admin].nil?
  
    

 end



   
  end 

  def ane_created

     @ane = Ane.new(params[:ane])
     @ane.creater = session[:email]
   
    respond_to do |format|
      if @ane.save
        format.html { redirect_to dashboard_path, notice: 'Notice: ANE created successfully.' }
        format.json { render json: @ane, status: :created, location: @ane }
      else
        format.html { redirect_to dashboard_path, notice: 'Error: Sorry somethimg went wrong. Please try again.'}
        format.json { render json: @ane.errors, status: :unprocessable_entity }
      end
    end
    
  end




def add_emission

    #if Tsp.find_by_creater(session[:email]).nil? && Circle.find_by_creater(session[:email]).nil? && Cne.find_by_creater(session[:email]).nil? && Ane.find_by_creater(session[:email]).nil?
     # redirect_to dashboard_path, notice: 'Error: Create a TSP and atleast one circle and atleast one CNE and atleast one ANE first.'

      #elsif Circle.find_by_creater(session[:email]).nil? && Cne.find_by_creater(session[:email]).nil? && Ane.find_by_creater(session[:email]).nil?
      #redirect_to dashboard_path, notice: 'Error: Create atleast one circle and atleast one CNE and atleast one ANE first.'

    #elsif Cne.find_by_creater(session[:email]).nil? && Ane.find_by_creater(session[:email]).nil?
     # redirect_to dashboard_path, notice: 'Error: Create atleast one CNE and atleast one ANE first.'

    #elsif Ane.find_by_creater(session[:email]).nil?
     # redirect_to dashboard_path, notice: 'Error: Create atleast one ANE first.'

    #else 
      @creater_email = session[:email]

        @emission_datas = Array.new(10) { EmissionData.new }
       #@emission_datas = EmissionData.new
    
     # respond_to do |format|
      #format.html # signup.html.erb
      #format.json { render json: @emission_datas }
    #end

   # if request.post? && !params[:name].nil? && !params[:admin].nil?
  
    

 #end



   
  end 

  def emission_added

     

    @emission_datas = params[:emission_datas].values.collect { |emission_data| EmissionData.new(emission_data) }
    if @emission_datas.all?(&:valid?)
      @emission_datas.each(&:save!)
      redirect_to dashboard_path, notice: 'Notice: Emission Data added successfully.'
      
      else
      redirect_to dashboard_path, notice: 'Error: Sorry somethimg went wrong. Please try again.'
    end

  end



def generate_report
  
  @tsp = User.find_by_email(session[:email]).organization
  @edata=BtsData.find(:all, :conditions => { :creator => session[:email] })#.reverse
  if !@edata.present?
    redirect_to dashboard_path, notice: 'Error: Please add Emission data first.'
  else
      @tco=0
      @i=1 
  end 
  
end


def calculate_emission
  
end



def cne_by_circle

  if params[:circle].present?

   @cne = Cne.find(:all, :conditions => { :circle => params[:circle], :creater => session[:email] })
    
  else
    @cne = []
  end

  respond_to do |format|
    format.html
  end
end

def myimport  
  if EmissionData.import(params[:file])  
  redirect_to dashboard_path, notice: "File imported."  

else
  redirect_to dashboard_path, notice: "File uploadation failed. Please upload CSV files only."
end 

end

def import
   ######  File handling start  ######
    tmp = params[:file].tempfile
    file = File.join("public", params[:file].original_filename)
    FileUtils.cp tmp.path, file
    ######  FIle handling end   ######

    ###### Excelx uploaing start #####
   oo = Roo::Excelx.new(file)
   oo.default_sheet = oo.sheets.first
   6.upto(oo.last_row) do |line|
   BtsData.new(:creator => session[:email], :site_name => oo.cell(line,'B'), :ip_name => oo.cell(line,'C'), :ip_site_id => oo.cell(line,'D'), :site_category => oo.cell(line,'E'), :eb_status => oo.cell(line,'F'), :invoice_from => oo.cell(line,'G'), :invoice_to => oo.cell(line,'H'), :invoice_month => oo.cell(line,'I'), :tenents_per_ip => oo.cell(line,'J'), :eb_opening_reading => oo.cell(line,'K'), :eb_closing_reading => oo.cell(line,'L'), :eb_units_consumption => oo.cell(line,'M'), :total_eb_cost => oo.cell(line,'N'), :opco_kwh => oo.cell(line,'O'), :opco_eb_cost => oo.cell(line,'P'), :eb_rate_per_unit => oo.cell(line,'Q'), :dg_capacity => oo.cell(line,'R'), :dg_opening_reading => oo.cell(line,'S'), :dg_closing_reading => oo.cell(line,'T'), :total_dg_run => oo.cell(line,'U'), :total_diesel_consumption => oo.cell(line,'V'), :total_diesel_cost => oo.cell(line,'W'), :opco_diesel_amount => oo.cell(line,'X'), :fuel_rate_per_ltr => oo.cell(line,'Y'), :total_site_dc_load => oo.cell(line,'Z'), :opco_dc_load => oo.cell(line,'AA'), :opco_load_percent => oo.cell(line,'AB'), :total_kwh_reading => oo.cell(line,'AJ'), :days_in_month => oo.cell(line,'AM'), :dg_rating => oo.cell(line,'AN'), :eb_availability => oo.cell(line,'AO'), :dg_run_per_day => oo.cell(line,'AP'), :kw_per_day => oo.cell(line,'AQ'), :eta => oo.cell(line,'AR'), :carbon_footprint => oo.cell(line,'AS'), :carbon_footprint_opco => oo.cell(line,'AT')).save
   end
   #FileUtils.rm file
    ##### Excelx Uploading end #######
    redirect_to dashboard_path, notice: "File imported."
end

end