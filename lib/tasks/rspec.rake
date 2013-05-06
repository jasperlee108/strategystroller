namespace :rspec do
  
  desc "Run all rspec tests"
  task :all => :environment do
    system("echo Running all rspec tests..")
    system('rspec ./spec')
  end

  desc "Run admin tests"
  task :admin => :environment do
    system("echo Running admin_user_spec test..")
    system("rspec ./spec/models/admin_user_spec.rb")
  end

  desc "Run goal tests"
  task :goal => :environment do
    system("echo Running goal_spec test..")
    system("rspec ./spec/models/goal_spec.rb")
  end

  desc "Run user tests"
  task :user => :environment do
    system("echo Running user_spec test..")
    system("rspec ./spec/models/user_spec.rb")
  end

  desc "Run activity tests"
  task :activity => :environment do
    system("echo Running activity_spec test..")
    system("rspec ./spec/models/activity_spec.rb")
  end

  desc "Run dimension tests"
  task :dimension => :environment do
    system("echo Running dimension_spec test..")
    system("rspec ./spec/models/dimension_spec.rb")
  end

  desc "Run project tests"
  task :project => :environment do
    system("echo Running project_spec test..")
    system("rspec ./spec/models/project_spec.rb")
  end

  desc "Run indicator tests"
  task :indicator => :environment do
    system("echo Running indicator_spec test..")
    system("rspec ./spec/models/indicator_spec.rb")
  end

  desc "Run form tests"
  task :form => :environment do
    system("echo Running form_spec test..")
    system("rspec ./spec/models/form_spec.rb")
  end

  desc "Run cu_helper tests"
  task :cu_helper => :environment do
    system("echo Running controller_unit_helper_spec test..")
    system("rspec ./spec/helpers/controller_unit_helper_spec.rb")
  end  

  desc "Run provider_helper tests"
  task :pro_helper => :environment do
    system("echo Running provider_helper_spec test..")
    system("rspec ./spec/helpers/provider_helper_spec.rb")
  end  

  desc "Run application_helper tests"
  task :app_helper => :environment do
    system("echo Running application_helper test..")
    system("rspec ./spec/helpers/application_helper_spec.rb")
  end  


end
