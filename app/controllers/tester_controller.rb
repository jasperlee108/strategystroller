class TesterController < ApplicationController

  ## Can use this from command line using the following:
  ## "rails console"
  ## "TesterController.new.runRspecTest"
  def runRspecTest
    
    ## Add further system calls as you add more Rspec tests
    
    ## UNIT TEST -- Model
    ## Template: system("rspec ./spec/models/xxx_spec.rb")
    
    system("echo Running goal_spec test..")
    system("rspec ./spec/models/goal_spec.rb")

    system("echo Running user_spec test..")
    system("rspec ./spec/models/user_spec.rb")
    
    system("echo Running company_spec test..")
    system("rspec ./spec/models/company_spec.rb")
    
    system("echo Running admin_user_spec test..")
    system("rspec ./spec/models/admin_user_spec.rb")
    
    ## FUNCTIONAL TEST -- Controller
    ## Template: system("rspec ./spec/controllers/xxx_spec.rb")
    
    system("echo Running authentication_controller_spec test..")
    system("rspec ./spec/controllers/authentication_controller_spec.rb")
    
  end
end
