require 'spec_helper'

describe AuthenticationController do

  describe "GET 'login'" do
    it "returns http success" do
      get 'login'
      response.should be_success
    end
  end

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

  describe "GET 'logout'" do
    it "returns http success" do
      get 'logout'
      response.should be_success
    end
  end

end
