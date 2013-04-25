require 'spec_helper'
require 'base64' 

describe ControllerUnitController do
  describe "GET #cu_review" do
    it "responds successfully with an redirect" do
      get :view_activity
      expect(response).should be_redirect
    end

    it "assigns a user" do
      get :view_activity
      assigns(:user).should_not be_nil
    end
  end

  describe "GET #setup_system" do
    it "responds successfully with an redirect" do
      get :setup_system
      expect(response).should be_redirect
    end

    it "assigns an application" do
      get :setup_system
      assigns(:years).should_not be_nil
    end
  end

  describe "GET #set_activity" do
    it "responds successfully with a redirect" do
      get :set_activity
      expect(response).should be_redirect
    end

  
  end

  describe "Testing Encode ID Helper" do
   	it "tries to encode form_id" do
   	  cu = ControllerUnitController.new 
   	  form_id = 5
   	  expected = Base64.encode64(form_id.to_s)
   	  observed = cu.encode_id(form_id)
   	  observed.should eq(expected)
   	end
  end

  describe "Testing Decode ID Helper" do
   	it "tries to decode form_id" do
   	  cu = ControllerUnitController.new 
   	  form_id = 5
   	  expected = Base64.decode64(form_id.to_s)
   	  observed = cu.decode_id(form_id)
   	  observed.should eq(expected)
   	end
  end

  describe "Encode URL Helper" do
   	it "tries to create url with form_id" do
   	  cu = ControllerUnitController.new 
   	  form_id = 5
   	  encoded_id = cu.encode_id(form_id.to_s)
      expected = "http://localhost:3000/forms?form_id=" + encoded_id.to_s #TEMP
   	  observed = cu.encode_url(form_id)
   	  observed.should eq(expected)
   	end
  end

  describe "Testing Extract ID Helper" do
   	it "tries to extract id from url" do
   	  cu = ControllerUnitController.new 
   	  url = "http://localhost:3000/forms?form_id=3244234" 
      expected = "3244234"
   	  observed = cu.extract_id(url)
   	  observed.should eq(expected)
   	end
  end
end
