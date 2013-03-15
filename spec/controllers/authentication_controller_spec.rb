require 'spec_helper'

describe AuthenticationController do

  ## DEFAULT: Login & Logout

  describe "GET 'login'" do
    it "returns http success" do
      get 'login'
      response.should be_success
    end
  end

  describe "GET 'logout'" do
    it "returns http success" do
      get 'logout'
      response.should be_success
    end
  end

  ## PENDING: Not yet implemented, so should pass as is

  describe "GET 'create_user'" do
    it "returns http success" do
      get 'create_user'
      response.should be_success
    end
  end

  describe "GET 'creation_token'" do
    it "returns http success" do
      get 'creation_token'
      response.should be_success
    end
  end

  ### NOTE: Using a mix of ruby format and Rspec format
  ### PURPOSE: To test if redirection works as expected

  CU = 0
  PROVIDER = 1
  STRATEGYSTROLLER = 1
  PETERDUERR = 2

  ## LOGIN - CU
  
  # CU Exists
  describe "POST 'login'" do
    it "should let existing CU logs in" do
      user = User.new(
        :name => "james",
        :password => "bond",
        :company_id => STRATEGYSTROLLER,
        :position => CU
      ).save
      post "login",
        :username => "james",
        :password => "bond",
        :company => { :name => STRATEGYSTROLLER.to_s }
      expect(response).to redirect_to("/controller_unit/controller_panel")
    end
  end

  # CU Does Not Exist
  describe "POST 'login'" do
    it "should let existing CU logs in" do
      user = User.new(
        :name => "james",
        :password => "bond",
        :company_id => STRATEGYSTROLLER,
        :position => CU
      ).save
      post "login",
        :username => "andy",
        :password => "warhol",
        :company => { :name => STRATEGYSTROLLER.to_s }
      expect(response).to redirect_to("/authentication/login")
    end
  end

  # CU Wrong Company
  describe "POST 'login'" do
    it "should let existing CU logs in" do
      user = User.new(
        :name => "james",
        :password => "bond",
        :company_id => STRATEGYSTROLLER,
        :position => CU
      ).save
      post "login",
        :username => "james",
        :password => "bond",
        :company => { :name => PETERDUERR.to_s }
      expect(response).to redirect_to("/authentication/login")
    end
  end

  ## LOGIN - Provider
  
  # Provider Exists
  describe "POST 'login'" do
    it "should let existing CU logs in" do
      user = User.new(
        :name => "andy",
        :password => "warhol",
        :company_id => STRATEGYSTROLLER,
        :position => PROVIDER
      ).save
      post "login",
        :username => "andy",
        :password => "warhol",
        :company => { :name => STRATEGYSTROLLER.to_s }
      expect(response).to redirect_to("/provider/provider_panel")
    end
  end

  # Provider Does Not Exist
  describe "POST 'login'" do
    it "should let existing CU logs in" do
      user = User.new(
        :name => "andy",
        :password => "warhol",
        :company_id => STRATEGYSTROLLER,
        :position => PROVIDER
      ).save
      post "login",
        :username => "james",
        :password => "bond",
        :company => { :name => STRATEGYSTROLLER.to_s }
      expect(response).to redirect_to("/authentication/login")
    end
  end

  # Provider Wrong Company
  describe "POST 'login'" do
    it "should let existing CU logs in" do
      user = User.new(
        :name => "andy",
        :password => "warhol",
        :company_id => STRATEGYSTROLLER,
        :position => PROVIDER
      ).save
      post "login",
        :username => "andy",
        :password => "warhol",
        :company => { :name => PETERDUERR.to_s }
      expect(response).to redirect_to("/authentication/login")
    end
  end

  ### EXTRA
  
  ## Running Rspec remotely (RoR)
  ## Credit: Yong Hoon Lee
  ## Source: https://sites.google.com/a/eecs.berkeley.edu/cs169-sp13/project/setting-up-a-deployment-site
  after(:each) do
    User.delete_all
  end

end
