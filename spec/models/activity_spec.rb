require 'spec_helper'

describe Activity do
  
  ### NOTE: Using ruby format, not Rspec
  ### TODO: user_ids for "team" is not yet tested
  
  def generate
    activity = Activity.new(
    :name => "Aktivitat",
    :description => "Wall of Text",
    :phase => Activity::PREREQUISITES_FULFILLED,
    :startDate => Date.new(2013,03,26),
    :endDate => Date.new(2013,03,27),
    :targetManp => 20,
    :targetCost => 50.50,
    :notes => "Another Wall of Text",
    :actualManp => 10,
    :actualCost => 25.25,
    :actualProg => Activity::IN_PROGRESS,
    :statusNotes => "A Different Wall of Text",
    :project_id => 1,
    :team => "James Bond, Andy Warhol",
    :short_name => "Akti"
    )
    return activity    
  end
  
  ## Default
  it "should pass assert true sanity test" do
    assert(true, "Did not pass sanity check")
  end

  ## All Correct
  it "should behave correctly on good inputs" do
    activity = generate()
    assert(activity.save, "It won't save on good inputs")
  end

  ### NAME
  
  ## Name is not empty
  it "should not have empty Name" do
    name = ""
    activity = generate()
    activity.name = name
    assert(!activity.save, "It saves on empty Name")
  end
  
  ## Name max = 80
  it "should not have Name longer than 80 characters" do
    name = (0...81).map{ ( 65+rand(26) ).chr }.join
    activity = generate()
    activity.name = name
    assert(!activity.save, "It saves on Name longer than 80 characters")
  end
  
  ### DESCRIPTION
  
  ## Description can be empty
  it "can have empty Description" do
    description = ""
    activity = generate()
    activity.description = description
    assert(activity.save, "It won't save on empty Description")
  end
  
  ## Description max = 600
  it "should not have Description longer than 600 characters" do
    description = (0...601).map{ ( 65+rand(26) ).chr }.join
    activity = generate()
    activity.description = description
    assert(!activity.save, "It saves on Description longer than 600 characters")
  end
  
  ### PHASE
  
  ## Phase is not empty
  it "can not have empty Phase" do
    phase = nil
    activity = generate()
    activity.phase = phase
    assert(!activity.save, "It saves on empty Phase")
  end
  
  ## Phase is an integer
  it "will not allow a non-integer phase" do
    phase = "1-Concept completed"
    activity = generate()
    activity.phase = phase
    assert(!activity.save, "It saves on Phase with a non-integer phase")
  end

  ## Phase is in Activity::PHASES
  it "will not allow a phase not in Activity::PHASES" do
    phase = 5
    activity = generate()
    activity.phase = phase
    assert(!activity.save, "It saves on an integer Phase not present in Activity::PHASES")
  end

  ## Phase allows Activity::PROJECT_MANAGEMENT
  it "will allow the phase Activity::PROJECT_MANAGEMENT" do
    phase = Activity::PROJECT_MANAGEMENT
    activity = generate()
    activity.phase = phase
    assert(activity.save, "It will not save on Activity::PROJECT_MANAGEMENT: #{Activity::PROJECT_MANAGEMENT}")
  end
  
  ### DATE
  
  ## Start Date is valid
  it "should have valid Start Date" do
    startDate = "random"
    activity = generate()
    activity.startDate = startDate
    assert(!activity.save, "It saves on invalid Start Date")
  end

  ## End Date is valid
  it "should have valid End Date" do
    endDate = "random"
    activity = generate()
    activity.endDate = endDate
    assert(!activity.save, "It saves on invalid End Date")
  end

  ## Start Date before End Date
  it "should have Start Date before End Date" do
    startDate = Date.new(2013,03,27)
    endDate = Date.new(2013,03,26)
    activity = generate()
    activity.startDate = startDate
    activity.endDate = endDate
    assert(!activity.save, "It saves on End Date before Start Date")
  end

  ## Date doesn't have February 30th
  # NOTE: date is in string, the validator will check its correctness,
  # if not, it will error out before even reaching the validator
  it "should have real Date" do
    startDate = "2013-02-30"
    activity = generate()
    activity.startDate = startDate
    assert(!activity.save, "It saves on non existence Date")
  end

  ### TARGET MAN POWER
  
  ## TargetManp is not empty
  it "should not have empty TargetManp" do
    targetManp = nil
    activity = generate()
    activity.targetManp = targetManp
    assert(!activity.save, "It saves on empty TargetManp")
  end
  
  ## TargetManp = integer
  it "should have TargetManp as an integer" do
    targetManp = "random"
    activity = generate()
    activity.targetManp = targetManp
    assert(!activity.save, "It saves on TargetManp = " + targetManp.to_s)
  end

  ## TargetManp = integer
  it "should have TargetManp as an integer" do
    targetManp = 10.50
    activity = generate()
    activity.targetManp = targetManp
    assert(!activity.save, "It saves on TargetManp = " + targetManp.to_s)
  end
  
  ## TargetManp = integer > 0
  it "should have TargetManp as an integer > 0" do
    targetManp = -5
    activity = generate()
    activity.targetManp = targetManp
    assert(!activity.save, "It saves on TargetManp = " + targetManp.to_s)
  end

  ### TARGET COST
  
  ## TargetCost is not empty
  it "should not have empty TargetCost" do
    targetCost = nil
    activity = generate()
    activity.targetCost = targetCost
    assert(!activity.save, "It saves on empty TargetCost")
  end
  
  ## TargetCost = decimal
  it "should have TargetCost as a decimal" do
    targetCost = "random"
    activity = generate()
    activity.targetCost = targetCost
    assert(!activity.save, "It saves on TargetCost = " + targetCost.to_s)
  end

  ## TargetCost = decimal > 0
  it "should have TargetCost as a decimal > 0" do
    targetCost = -5
    activity = generate()
    activity.targetCost = targetCost
    assert(!activity.save, "It saves on TargetCost = " + targetCost.to_s)
  end

  ### NOTES
  
  ## Notes can be empty
  it "can have empty Notes" do
    notes = ""
    activity = generate()
    activity.notes = notes
    assert(activity.save, "It won't save on empty Notes")
  end
  
  ## Notes max = 600
  it "should not have Notes longer than 600 characters" do
    notes = (0...601).map{ ( 65+rand(26) ).chr }.join
    activity = generate()
    activity.notes = notes
    assert(!activity.save, "It saves on Notes longer than 600 characters")
  end

  ### ACTUAL MAN POWER
  
  ## ActualManp is not empty
  it "should not have empty ActualManp" do
    actualManp = nil
    activity = generate()
    activity.actualManp = actualManp
    assert(!activity.save, "It saves on empty ActualManp")
  end
  
  ## ActualManp = integer
  it "should have ActualManp as an integer" do
    actualManp = "random"
    activity = generate()
    activity.actualManp = actualManp
    assert(!activity.save, "It saves on ActualManp = " + actualManp.to_s)
  end

  ## ActualManp = integer
  it "should have ActualManp as an integer" do
    actualManp = 10.50
    activity = generate()
    activity.actualManp = actualManp
    assert(!activity.save, "It saves on ActualManp = " + actualManp.to_s)
  end
  
  ## ActualManp = integer > 0
  it "should have ActualManp as an integer > 0" do
    actualManp = -5
    activity = generate()
    activity.actualManp = actualManp
    assert(!activity.save, "It saves on ActualManp = " + actualManp.to_s)
  end

  ### ACTUAL COST
  
  ## ActualCost is not empty
  it "should not have empty ActualCost" do
    actualCost = nil
    activity = generate()
    activity.actualCost = actualCost
    assert(!activity.save, "It saves on empty ActualCost")
  end
  
  ## ActualCost = decimal
  it "should have ActualCost as a decimal" do
    actualCost = "random"
    activity = generate()
    activity.actualCost = actualCost
    assert(!activity.save, "It saves on ActualCost = " + actualCost.to_s)
  end

  ## ActualCost = decimal > 0
  it "should have ActualCost as a decimal > 0" do
    actualCost = -5
    activity = generate()
    activity.actualCost = actualCost
    assert(!activity.save, "It saves on ActualCost = " + actualCost.to_s)
  end

  ### ACTUAL PROGRESS
  
  ## ActualProg is not empty
  it "should not have empty ActualProg" do
    actualProg = nil
    activity = generate()
    activity.actualProg = actualProg
    assert(!activity.save, "It saves on empty ActualProg")
  end
  
  ## ActualProg is an number
  it "should not have ActualProg that is not number" do
    actualProg = "In progress"
    activity = generate()
    activity.actualProg = actualProg
    assert(!activity.save, "It saves on ActualProg that is not a Number")
  end

  ## ActualProg is an Integer
  it "should not have ActualProg that is not an integer" do
    actualProg = 1.0
    activity = generate()
    activity.actualProg = actualProg
    assert(!activity.save, "It saves on ActualProg that is not an Integer")
  end

  ## ActualProg is in Activity::PROGRESS
  it "should not have ActualProg that is not in Activity.PROGRESS" do
    actualProg = 10
    activity = generate()
    activity.actualProg = actualProg
    assert(!activity.save, "It saves on ActualProg that is not in Activity.PROGRESS")
  end

  ### STATUS NOTES
  
  ## Status Notes can be empty
  it "can have empty Status Notes" do
    statusNotes = ""
    activity = generate()
    activity.statusNotes = statusNotes
    assert(activity.save, "It won't save on empty Status Notes")
  end
  
  ## Status Notes max = 600
  it "should not have Status Notes longer than 600 characters" do
    statusNotes = (0...601).map{ ( 65+rand(26) ).chr }.join
    activity = generate()
    activity.statusNotes = statusNotes
    assert(!activity.save, "It saves on Status Notes longer than 600 characters")
  end

  ### TEAM
  
  ## Team Notes can be empty
  it "can have empty Team" do
    team = ""
    activity = generate()
    activity.team = team
    assert(activity.save, "It won't save on empty Team")
  end
  
  ## Team Notes max = 600
  it "should not have Team longer than 600 characters" do
    team = (0...601).map{ ( 65+rand(26) ).chr }.join
    activity = generate()
    activity.team = team
    assert(!activity.save, "It saves on Team longer than 600 characters")
  end

  ### SHORT NAME
  
  ## Short Name is not empty
  it "should not have empty Short Name" do
    short_name = ""
    activity = generate()
    activity.short_name = short_name
    assert(!activity.save, "It saves on empty Short Name")
  end
  
  ## Short Name max = 30
  it "should not have Short Name longer than 30 characters" do
    short_name = (0...31).map{ ( 65+rand(26) ).chr }.join
    activity = generate()
    activity.short_name = short_name
    assert(!activity.save, "It saves on Short Name longer than 30 characters")
  end

  ### EXTRA
  
  ## Running Rspec remotely (RoR)
  ## Credit: Yong Hoon Lee
  ## Source: https://sites.google.com/a/eecs.berkeley.edu/cs169-sp13/project/setting-up-a-deployment-site
  after(:each) do
    Activity.delete_all
  end
end
