FactoryGirl.define do

  ## User
  factory :user, class: User do
    username "Test User"
    email "test@user.com"
    controlling_unit true

    after (:build) do |user|
      user.password_confirmation = user.password = "testpassword"
      user.skip_confirmation!
    end

    before (:create) do |user|
      user.password_confirmation = user.password = "testpassword"
      user.skip_confirmation!
    end

  end

  ## Application
  factory :application, class: Application do
    company "Test Company"
    curr_year 2013
  end

  ## Dimension
  factory :dimension, class: Dimension do
    name "Test Dimension"
    status 0.7550
  end


  ## Goal
  factory :goal, class: Goal do
    name  "Test Goal"
    need  "Call for action"
    justification  "Justification of specific goal"
    focus  "Strategic approach"
    notes  "Notes for goal"
    status  0.01
    dimension_id  1
    user_id  1
    prereq  []
    short_name  "TGoal"
  end

  ## Indicator
  factory :indicator, class: Indicator do
    name "Test Indicator"
    description "A good indicator for testing."
    source  "Indicator Source"
    unit  "owner unit of ind"
    freq  [3,6,9,12]
    year  2013
    reported_values  [0.2, 0.65]
    indicator_type  "average"
    prognosis 0.6543
    dir "more is better"
    actual  0.055
    target  0.105
    notes  "Notes on the indicator."
    diff  0.05
    status  0.755
    contributing_projects_status 0.693
    status_notes  "Notes on the indicator's status."
    user_id  1
    short_name "TInd"
  end

  ## Project
  factory :project, class: Project do
    name  "Test Project"
    description  "A good project for testing."
    startDate  Date.new(2013,03,27)
    endDate  Date.new(2014,03,28)
    actual_duration  15
    target_duration  52
    target_manp  5
    target_cost  10.5
    inplan  true
    compensation  true
    notes  "Notes on the project."
    actual_manp  10
    actual_cost  0.205
    status_prog  0.755
    status_ms {{ Activity::ONGOING      =>  Activity::NOT_YET_STARTED,
                 Activity::CONCEPT_COMPLETED       =>  Activity::IN_PROGRESS,
                 Activity::PREREQUISITES_FULFILLED =>  Activity::NOT_YET_STARTED,
                 Activity::IMPLEMENTATION_RUNNING  =>  Activity::NOT_YET_STARTED,
                 Activity::PROJECT_EFFECTIVE       =>  Activity::NOT_YET_STARTED }}
    status_manp  10
    status_cost  10.5
    status_global  0.505
    status_notes  "Notes on the project's status."
    head_id  1
    steer_id  1
    team  "James Bond, Andy Warhol"
    yearly_target_manp  {{}} # kept as an example: {2013 => BigDecimal(5.57,10), 2014 => BigDecimal(7.57,10)},
    yearly_target_cost  {{}} # kept as an example: {2013 => BigDecimal(25.25,10), 2014 => BigDecimal(38.07,10)},
    short_name  "TProj"
  end


  ## Activity
  factory :activity, class: Activity do
    name  "Test Activity"
    description  "A good activity for testing."
    phase  Activity::PREREQUISITES_FULFILLED
    startDate  Date.new(2013,03,26)
    endDate  Date.new(2013,03,27)
    targetManp  20
    targetCost  50.50
    notes  "Notes on the activity."
    actualManp  10
    actualCost  25.25
    actualProg  Activity::IN_PROGRESS
    statusNotes  "Notes on the activity's status"
    project_id  1
    team  "James Bond, Andy Warhol"
    short_name  "TAct"
  end

end
