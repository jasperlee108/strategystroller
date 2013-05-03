namespace :fake_data do
  
  ## INFO
  GOAL = 1
  INDICATOR = 2
  PROJECT = 3
  ACTIVITY = 4
  
  ### AVAILABLE RAKE ###
  
  ## ALL
  desc "Populating with fake data"
  task :all => :environment do
    system("echo Populating with fake data..")
    how_many = 5

    system("echo Creating fake CU..")
    create_CU(how_many/2)

    system("echo Creating fake provider..")
    create_provider(how_many/2)

    system("echo Creating fake goal..")
    create_goal(how_many)

    system("echo Creating fake indicator..")
    create_indicator(how_many)

    system("echo Creating fake project..")
    create_project(how_many)

    system("echo Creating fake activity..")
    create_activity(how_many)

    system("echo Database successfully populated with fake data!")
  end
  
  ## ALL USER
  desc "Populating with fake user"
  task :user => :environment do
    system("echo Populating with fake user..")
    how_many = 5

    system("echo Creating fake CU..")
    create_CU(how_many/2)

    system("echo Creating fake provider..")
    create_provider(how_many/2)
    
    system("echo Database successfully populated with fake user!")
  end

  ## CU
  desc "Populating with fake CU"
  task :cu => :environment do
    system("echo Populating with fake CU..")
    how_many = 5

    system("echo Creating fake CU..")
    create_CU(how_many/2)
    
    system("echo Database successfully populated with fake CU!")
  end

  ## PROVIDER
  desc "Populating with fake Provider"
  task :provider => :environment do
    system("echo Populating with fake Provider..")
    how_many = 5

    system("echo Creating fake provider..")
    create_provider(how_many/2)
    
    system("echo Database successfully populated with fake Provider!")
  end

  ## EVERYTHING ELSE BESIDES USER
  ## GOAL + INDICATOR + PROJECT + ACTIVITY
  ## NOTE:: Children of User, so at least one CU & one Provider have to exist
  desc "Populating with fake of everything else besides user"
  task :else => :environment do
    system("echo Populating with fake of everything else besides user..")
    how_many = 5

    system("echo Creating fake goal..")
    create_goal(how_many)

    system("echo Creating fake indicator..")
    create_indicator(how_many)

    system("echo Creating fake project..")
    create_project(how_many)

    system("echo Creating fake activity..")
    create_activity(how_many)

    system("echo Database successfully populated with fake of everything else besides user!")
  end
  
  ## GOAL
  ## NOTE:: Children of Dimension, so at least one Dimension has to exist
  ## All 4 Dimension are already auto generated
  desc "Populating with fake goal"
  task :goal => :environment do
    system("echo Populating with fake goal..")
    how_many = 5

    system("echo Creating fake goal..")
    create_goal(how_many)
    
    system("echo Database successfully populated with fake goal!")
  end
  
  ## INDICATOR
  ## NOTE:: Children of Goal, so at least one Goal has to exist
  desc "Populating with fake indicator"
  task :indicator => :environment do
    system("echo Populating with fake indicator..")
    how_many = 5

    system("echo Creating fake indicator..")
    create_indicator(how_many)
    
    system("echo Database successfully populated with fake indicator!")
  end
  
  ## PROJECT
  ## NOTE:: Children of Indicator, so at least one Indicator has to exist
  desc "Populating with fake project"
  task :project => :environment do
    system("echo Populating with fake project..")
    how_many = 5

    system("echo Creating fake project..")
    create_project(how_many)
    
    system("echo Database successfully populated with fake project!")
  end
  
  ## ACTIVITY
  ## NOTE:: Children of Project, so at least one Project has to exist
  desc "Populating with fake activity"
  task :activity => :environment do
    system("echo Populating with fake activity..")
    how_many = 5

    system("echo Creating fake activity..")
    create_activity(how_many)
    
    system("echo Database successfully populated with fake activity!")
  end
  
  ### HELPER METHODS ###
  
  def create_user(how_many, is_CU)
    for _ in how_many.times
      first_name = (0...5).map{ ( 65+rand(26) ).chr }.join
      last_name = (0...5).map{ ( 65+rand(26) ).chr }.join
      User.create(
        :username => first_name + ' ' + last_name,
        :email => first_name + '@' + last_name + '.com',
        :password => first_name + last_name,
        :password_confirmation => first_name + last_name,
        :business_code => first_name[0] + last_name[0],
        :controlling_unit => is_CU
      ).save!
    end
  end
  
  def create_CU(how_many)
    create_user(how_many, true)
  end

  def create_provider(how_many)
    create_user(how_many, false)
  end

  def pick_provider_ids
    return User.where(:controlling_unit => false).select('id')
  end

  def create_goal(how_many)
    @dimension = Dimension.select('id')
    @user = pick_provider_ids()
    @all_goals = Goal.select('name')
    ctrl = ApplicationController.new
    for _ in how_many.times
      random_string = (0...5).map{ ( 65+rand(26) ).chr }.join
      goal = Goal.new(
        :name => random_string,
        :short_name => random_string,
        :need => random_string,
        :justification => random_string,
        :focus => random_string,
        :notes => random_string,
        :status => rand(1..100),
        :dimension_id => @dimension.sample.id,
        :user_id => @user.sample.id,
        :prereq => ""
      )
      if @all_goals != []
        goal.prereq = @all_goals.sample.name
      end
      goal.save!
      @all_goals = Goal.select('name')
      ctrl.save_form(GOAL, goal.user_id, goal.id)
    end
  end

  def create_indicator(how_many)
    @goal = Goal.select('id')
    @user = pick_provider_ids()
    frequency = ['M','Q','HY','Y']
    type = ['Average','Cumulative']
    direction = ['More is better','Less is better']
    ctrl = ApplicationController.new
    for _ in how_many.times
      random_string = (0...5).map{ ( 65+rand(26) ).chr }.join
      indicator = Indicator.new(
        :name => random_string,
        :short_name => random_string,
        :description => random_string,
        :source => random_string,
        :unit => random_string,
        :freq => frequency.sample,
        :indicator_type => type.sample,
        :dir => direction.sample,
        :actual => rand(1..100),
        :target => rand(1..100),
        :notes => random_string,
        :diff => rand(1..100),
        :status => rand(1..100),
        :status_notes => random_string,
        :goal_id => @goal.sample.id,
        :user_id => @user.sample.id
      )
      indicator.save!
      ctrl.save_form(INDICATOR, indicator.user_id, indicator.id)
    end
  end

  def create_project(how_many)
    @indicator = Indicator.select('id')
    @user = pick_provider_ids()
    bool = [true,false]
    ctrl = ApplicationController.new
    for _ in how_many.times
      random_string = (0...5).map{ ( 65+rand(26) ).chr }.join
      project = Project.new(
        :name => random_string,
        :short_name => random_string,
        :description => random_string,
        :startDate => Date.yesterday,
        :endDate => Date.tomorrow,
        :target_duration => rand(1..100),
        :actual_duration => rand(1..100),
        :target_manp => rand(1..100),
        :target_cost => rand(1..100),
        :inplan => bool.sample,
        :compensation => bool.sample,
        :notes => random_string,
        :actual_manp => rand(1..100),
        :actual_cost => rand(1..100),
        :status_prog => rand(1..100),
        :status_ms => rand(1..100),
        :status_manp => rand(1..100),
        :status_cost => rand(1..100),
        :status_global => rand(1..100),
        :status_notes => random_string,
        :indicator_id => @indicator.sample.id,
        :head_id => @user.sample.id,
        :steer_id => @user.sample.id,
        :team => random_string
      )
      project.save!
      ctrl.save_form(PROJECT, project.head_id, project.id)
    end
  end

  def create_activity(how_many)
    @project = Project.select('id')
    phase = ["1-Concept completed","2-Prerequisites fulfilled","3-Implementation running","4-Project effective"]
    progress = ["1-Not yet started","2-In progress","3-Activity completed"]
    for _ in how_many.times
      random_string = (0...5).map{ ( 65+rand(26) ).chr }.join
      activity = Activity.new(
        :name => random_string,
        :short_name => random_string,
        :description => random_string,
        :phase => phase.sample,
        :startDate => Date.yesterday,
        :endDate => Date.tomorrow,
        :targetManp => rand(1..100),
        :targetCost => rand(1..100),
        :notes => random_string,
        :actualManp => rand(1..100),
        :actualCost => rand(1..100),
        :actualProg => progress.sample,
        :statusNotes => random_string,
        :project_id => @project.sample.id,
        :team => random_string
      ).save!
    end
  end

end
