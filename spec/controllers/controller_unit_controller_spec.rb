require 'spec_helper'
require 'base64' 

describe ControllerUnitController do

  before :all do
    User.delete_all
    Goal.delete_all
    Form.delete_all
    Application.delete_all
  end

  before :each do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    @current_user = create(:user, controlling_unit: true, email: "cucontroller@test.com")
    sign_in :user, @current_user
  end

  after :each do
    User.delete_all
  end

  describe "GET #setup_system" do
    it "responds successfully with an redirect" do
      sign_out @current_user
      get :setup_system
      assert_response(:redirect)
    end

    it "assigns an application" do
      get :setup_system
      assigns(@years).should_not be_nil
    end
  end

  #TODO fill this in
  describe "#clean_list helper" do

  end


  describe "POST #set_goal" do

    context "when attributes are valid" do
      before :each do
        provider = create(:user, controlling_unit: false, username: "Provider In Charge", email: "providerincucctrl@test.com")
        post :set_goal, goal: { name: "Test Goal", dimension_id: 1, user_id: provider, short_name: "TGoal", need: "default", justification: "default", focus: "default", status: 0 }
      end

      after :each do
        Goal.delete_all
        Form.delete_all
        User.delete_all
      end

      it "saves the goal if the form is saved" do
         assert(Goal.count.nonzero?, "Goal did not save.")
         assert(Form.count.nonzero?, "Form did not save.")
      end

      it "sends the user a notice on success" do
        assert (not flash[:notice].empty?)
      end

      it "sends the user the right notice on success" do
        assert_equal("Goal successfully saved! A form has been sent to Provider In Charge." ,flash[:notice])
      end

    end

    context "when attributes are invalid" do
      before :each do
        post :set_goal, :goal => {}
      end

      it "sends the user an error" do
        assert (not flash[:error].empty?)
      end

      it "sends the user the expected error" do
        #post :set_goal, :params => { :goal => {}}
        assert_equal("ERROR: Goal was not saved! Please fill out all required fields." ,flash[:error])
      end
    end

    it "redirects to the review path" do
      redirect_to controller: "controller_unit", action: "cu_review"
    end

  end


  describe "POST #set_indicator" do
    before :all do
      Indicator.delete_all
      User.delete_all
      Goal.delete_all
    end
    context "valid parameters" do
      before :each do
        create(:goal, name: "Goal 1")
        create(:goal, name: "Goal 2")
        provider = create(:user, controlling_unit: false, username: "Provider In Charge", email: "providerincucctrl@test.com")
        post :set_indicator, indicator: { name: "Test Indicator", user_id: provider, short_name: "TInd", goal_ids: ["", 1, 2] }
      end

      after :each do
        Indicator.delete_all
        User.delete_all
        Goal.delete_all
      end

      it "saves an indicator object" do
        assert(Indicator.count == 1, "Failed to save on valid input")
      end

      it "correctly handles blank strings in goal_ids in saving" do
        assert(Indicator.last.goal_ids == [1,2], "Failed to save correctly on valid input")
      end

    end

    context "passed invalid parameters" do

    end
  end

  describe "POST #set_project" do

  end

  describe "POST #applications" do

    it "redirects from 'Save Setup' correctly" do
      post :applications, commit: 'Save Setup'
      redirect_to controller: "controller_unit", action: "setup_system"
    end

    it "redirects from 'Create User(s)' correctly" do
      post :applications, commit: 'Create User(s)'
      redirect_to controller: "controller_unit", action: "create_users"
    end

    it "redirects from 'Remove User(s)' correctly" do
      post :applications, commit: 'Remove User(s)'
      redirect_to controller: "controller_unit", action: "remove_users"
    end

  end

  describe "POST #setup_system" do
    context "valid application input" do
      before :each do
        post :setup_system, application: { company: "Test Company", curr_year: 2013 }
      end
      after :each do
        Application.delete_all
      end

      it "saves a new application" do
        assert(Application.count.nonzero?, "Failed to save a valid application in system setup.")
      end

      it "alerts the user that it was successful" do
        assert_equal("Setup successfully saved!" ,flash[:notice])
      end
    end

    context "invalid application input" do
      before :each do
        post :setup_system, application: { company: "Test Company"  }
      end
      after :each do
        Application.delete_all
      end

      it "fails to save a new application" do
        assert(Application.count.zero?, "Saved an invalid application in system setup.")
      end

      it "alerts the user that it was not successful" do
        assert_equal("ERROR: Setup was not saved" ,flash[:error])
      end
    end
  end

  describe "#all_" do
    it "redirects on all_data" do
      get :all_data
      assert_response(:success)
    end

    it "redirects on all_activity" do
      get :all_activity
      assert_response(:success)
    end
    it "redirects on all_project" do
      get :all_project
      assert_response(:success)
    end

    it "redirects on all_indicator" do
      get :all_indicator
      assert_response(:success)
    end
    it "redirects on all_goal" do
      get :all_goal
      assert_response(:success)
    end
    it "redirects on all_dimension" do
      get :all_dimension
      assert_response(:success)
    end
    it "redirects on all_form" do
      get :all_form
      assert_response(:success)
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
