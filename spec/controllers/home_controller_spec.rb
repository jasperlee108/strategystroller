require 'spec_helper'

describe HomeController do

  describe "GET 'index'" do

    before :each do
      @request.env["devise.mapping"] = Devise.mappings[:user]
    end

    after :each do
      User.delete_all
    end

    it "returns http redirect" do
      get 'index'
      assert_response(:redirect)
    end

    it "routes a user not logged in to login" do
      get 'index'
      ## Should be redirected right away,
      ## and not render anything.
      response.should redirect_to('/users/login')
    end

    it "redirects a provider to forms_composite" do
      @current_user = create(:user, controlling_unit: false)
      sign_in :user, @current_user
      get 'index'
      response.should redirect_to(:controller => "provider", :action => "forms_composite")
    end

    it "redirects a CU to setup the system if the system is uninitialized" do
      Application.delete_all
      @current_user = create(:user, controlling_unit: true)
      sign_in :user, @current_user
      get 'index'
      response.should redirect_to(:controller => "controller_unit", :action => "setup_system")
    end

    it "redirects a CU to their homepage (all_form) if the system has been initialized" do
      create :application
      @current_user = create(:user, controlling_unit: true)
      sign_in :user, @current_user
      get 'index'
      response.should redirect_to(:controller => "controller_unit", :action => "all_form")
    end
  end

end
