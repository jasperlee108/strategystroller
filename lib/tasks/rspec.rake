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

end
