class TesterController < ApplicationController

  ## Can use this from command line using the following:
  ## "rails console"
  ## "TesterController.new.runRspecTest"
  def runRspecTest(test)
    
    ## Add further system calls as you add more Rspec tests
    if test.empty?
      test = 'all'
    end
    
    ## UNIT TEST -- Model
    ## Template: system("rspec ./spec/models/xxx_spec.rb")
    
    if test == 'goal' or test == 'all'
      system("echo Running goal_spec test..")
      system("rspec ./spec/models/goal_spec.rb")
    end
    
    if test == 'user' or test == 'all'
      system("echo Running user_spec test..")
      system("rspec ./spec/models/user_spec.rb")
    end
    
    if test == 'company' or test == 'all'
      system("echo Running company_spec test..")
      system("rspec ./spec/models/company_spec.rb")
    end
    
    if test == 'admin' or test == 'all'
      system("echo Running admin_user_spec test..")
      system("rspec ./spec/models/admin_user_spec.rb")
    end
    
    ## FUNCTIONAL TEST -- Controller
    ## Template: system("rspec ./spec/controllers/xxx_spec.rb")
    
    if test == 'authentication' or test == 'all'
      system("echo Running authentication_controller_spec test..")
      system("rspec ./spec/controllers/authentication_controller_spec.rb")
    end
    
  end
end
