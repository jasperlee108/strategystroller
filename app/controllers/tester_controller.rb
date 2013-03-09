class TesterController < ApplicationController

  ## Can use this from command line using the following:
  ## "rails console"
  ## "TesterController.new.runRspecTest"
  def runRspecTest
    
    ## Add further system calls as you add more Rspec tests
    ## Template: system("rspec ./spec/models/xxx_spec.rb")
    system("rspec ./spec/models/goal_spec.rb")
    system("rspec ./spec/models/company_spec.rb")
    
  end
end
