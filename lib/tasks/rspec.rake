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

end
