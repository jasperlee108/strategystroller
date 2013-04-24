require 'spec_helper'

describe HomeController do

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      ## Should be redirected right away,
      ## and not render anything
      response.should redirect_to('/users/login')
    end
  end

end
