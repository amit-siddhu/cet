require 'spec_helper'

describe "users" do

 # let(:base_title) { "I2TB-CET" }

  describe "Login page" do

    
    it "should have the base title" do
      visit '/'
      page.should have_selector('title', :text => "I2TB-CET")
    end
  
    it "should not have a custom page title" do
      visit '/'
      page.should_not have_selector('title', :text => '| Login')
    end

  end

  describe "SignUp page" do

    
    it "should have the base title" do
      visit '/signup'
      page.should have_selector('title', :text => "I2TB-CET")
    end

    it "should not have a custom page title" do
      visit '/signup'
      page.should_not have_selector('title', :text => '| SignUp')
    end

  end

  describe "Registration page" do

    
    it "should have the base title" do
      visit '/registration'
      page.should have_selector('title', :text => "I2TB-CET")
    end

	it "should not have a custom page title" do
      visit '/registration'
      page.should_not have_selector('title', :text => '| Registration')
    end

  end

  describe "Dashboard page" do

   
    it "should have the base title" do
      visit '/registration'
      page.should have_selector('title', :text => "I2TB-CET")
    end

    it "should not have a custom page title" do
      visit '/registration'
      page.should_not have_selector('title', :text => '| Registration')
    end

  end

  describe "Reset-Password page" do

    
    it "should have the base title" do
      visit '/password_reset'
      page.should have_selector('title', :text => "I2TB-CET")
    end

    it "should not have a custom page title" do
      visit '/password_reset'
      page.should_not have_selector('title', :text => '| Reset-Password')
    end

  end

end