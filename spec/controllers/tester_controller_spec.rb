require 'spec_helper'

describe TesterController do

  describe "GET 'runRspecTest'" do
    it "returns http success" do
      get 'runRspecTest'
      response.should be_success
    end
  end

end
