require 'spec_helper'

describe Activity do
  
  ### NOTE: Using ruby format, not Rspec
  
  ## Default
  it "should pass assert true sanity test" do
    assert(true, "Did not pass sanity check")
  end

  ## All Correct
  it "should behave correctly on good inputs" do
    activity = Activity.new(
    :name => "Aktivitat",
    :description => "Wall of Text",
    :phase => "Projektphasen",
    :startDate => Date.new(2013,03,26),
    :endDate => Date.new(2013,03,27),
    :targetManp => 20,
    :targetCost => 50.50,
    :notes => "Another Wall of Text",
    :actualManp => 10,
    :actualCost => 25.25,
    :actualProg => 75.00,
    :statusNotes => "A Different Wall of Text"
    )
    assert(activity.save, "It won't save on good inputs")
  end

  ### NAME
  
  ## Name is not empty
  it "should not have empty Name" do
    activity = Activity.new(
    :name => "",
    :description => "Wall of Text",
    :phase => "Projektphasen",
    :startDate => Date.new(2013,03,26),
    :endDate => Date.new(2013,03,27),
    :targetManp => 20,
    :targetCost => 50.50,
    :notes => "Another Wall of Text",
    :actualManp => 10,
    :actualCost => 25.25,
    :actualProg => 75.00,
    :statusNotes => "A Different Wall of Text"
    )
    assert(!activity.save, "It saves on empty Name")
  end
  
  ## Name max = 80
  it "should not have Name longer than 80 characters" do
    activity = Activity.new(
    :name => (0...81).map{ ( 65+rand(26) ).chr }.join,
    :description => "Wall of Text",
    :phase => "Projektphasen",
    :startDate => Date.new(2013,03,26),
    :endDate => Date.new(2013,03,27),
    :targetManp => 20,
    :targetCost => 50.50,
    :notes => "Another Wall of Text",
    :actualManp => 10,
    :actualCost => 25.25,
    :actualProg => 75.00,
    :statusNotes => "A Different Wall of Text"
    )
    assert(!activity.save, "It saves on Name longer than 80 characters")
  end
  
  ### DESCRIPTION
  
  ## Description can be empty
  it "can have empty Description" do
    activity = Activity.new(
    :name => "Aktivitat",
    :description => "",
    :phase => "Projektphasen",
    :startDate => Date.new(2013,03,26),
    :endDate => Date.new(2013,03,27),
    :targetManp => 20,
    :targetCost => 50.50,
    :notes => "Another Wall of Text",
    :actualManp => 10,
    :actualCost => 25.25,
    :actualProg => 75.00,
    :statusNotes => "A Different Wall of Text"
    )
    assert(activity.save, "It saves on empty Description")
  end
  
  ## Description max = 600
  it "should not have Description longer than 600 characters" do
    activity = Activity.new(
    :name => "Aktivitat",
    :description => (0...601).map{ ( 65+rand(26) ).chr }.join,
    :phase => "Projektphasen",
    :startDate => Date.new(2013,03,26),
    :endDate => Date.new(2013,03,27),
    :targetManp => 20,
    :targetCost => 50.50,
    :notes => "Another Wall of Text",
    :actualManp => 10,
    :actualCost => 25.25,
    :actualProg => 75.00,
    :statusNotes => "A Different Wall of Text"
    )
    assert(!activity.save, "It saves on Description longer than 600 characters")
  end
  
  ### PHASE
  
  ## Phase is not empty
  it "should not have empty Phase" do
    activity = Activity.new(
    :name => "Aktivitat",
    :description => "Wall of Text",
    :phase => "",
    :startDate => Date.new(2013,03,26),
    :endDate => Date.new(2013,03,27),
    :targetManp => 20,
    :targetCost => 50.50,
    :notes => "Another Wall of Text",
    :actualManp => 10,
    :actualCost => 25.25,
    :actualProg => 75.00,
    :statusNotes => "A Different Wall of Text"
    )
    assert(!activity.save, "It saves on empty Phase")
  end
  
  ## Phase max = 30
  it "should not have Phase longer than 30 characters" do
    activity = Activity.new(
    :name => "Aktivitat",
    :description => "Wall of Text",
    :phase => (0...31).map{ ( 65+rand(26) ).chr }.join,
    :startDate => Date.new(2013,03,26),
    :endDate => Date.new(2013,03,27),
    :targetManp => 20,
    :targetCost => 50.50,
    :notes => "Another Wall of Text",
    :actualManp => 10,
    :actualCost => 25.25,
    :actualProg => 75.00,
    :statusNotes => "A Different Wall of Text"
    )
    assert(!activity.save, "It saves on Phase longer than 30 characters")
  end
  
  ### DATE
  
  ## Start Date is valid
  it "should have valid Start Date" do
    activity = Activity.new(
    :name => "Aktivitat",
    :description => "Wall of Text",
    :phase => "Projektphasen",
    :startDate => "random",
    :endDate => Date.new(2013,03,27),
    :targetManp => 20,
    :targetCost => 50.50,
    :notes => "Another Wall of Text",
    :actualManp => 10,
    :actualCost => 25.25,
    :actualProg => 75.00,
    :statusNotes => "A Different Wall of Text"
    )
    assert(!activity.save, "It saves on invalid Start Date")
  end

  ## End Date is valid
  it "should have valid End Date" do
    activity = Activity.new(
    :name => "Aktivitat",
    :description => "Wall of Text",
    :phase => "Projektphasen",
    :startDate => Date.new(2013,03,26),
    :endDate => "random",
    :targetManp => 20,
    :targetCost => 50.50,
    :notes => "Another Wall of Text",
    :actualManp => 10,
    :actualCost => 25.25,
    :actualProg => 75.00,
    :statusNotes => "A Different Wall of Text"
    )
    assert(!activity.save, "It saves on invalid End Date")
  end

  ## Start Date before End Date
  it "should have Start Date before End Date" do
    activity = Activity.new(
    :name => "Aktivitat",
    :description => "Wall of Text",
    :phase => "Projektphasen",
    :startDate => Date.new(2013,03,27),
    :endDate => Date.new(2013,03,26),
    :targetManp => 20,
    :targetCost => 50.50,
    :notes => "Another Wall of Text",
    :actualManp => 10,
    :actualCost => 25.25,
    :actualProg => 75.00,
    :statusNotes => "A Different Wall of Text"
    )
    assert(!activity.save, "It saves on End Date before Start Date")
  end

  ## Date doesn't have February 30th
  # NOTE: date is in string, the validator will check its correctness,
  # if not, it will error out before even reaching the validator
  it "should have real Date" do
    activity = Activity.new(
    :name => "Aktivitat",
    :description => "Wall of Text",
    :phase => "Projektphasen",
    :startDate => "2013-02-30",
    :endDate => Date.new(2013,03,27),
    :targetManp => 20,
    :targetCost => 50.50,
    :notes => "Another Wall of Text",
    :actualManp => 10,
    :actualCost => 25.25,
    :actualProg => 75.00,
    :statusNotes => "A Different Wall of Text"
    )
    assert(!activity.save, "It saves on non existence Date")
  end

  ### TARGET MAN POWER
  
  ## TargetManp = integer
  it "should have TargetManp as an integer" do
    targetManp = "random"
    activity = Activity.new(
    :name => "Aktivitat",
    :description => "Wall of Text",
    :phase => "Projektphasen",
    :startDate => Date.new(2013,03,26),
    :endDate => Date.new(2013,03,27),
    :targetManp => targetManp,
    :targetCost => 50.50,
    :notes => "Another Wall of Text",
    :actualManp => 10,
    :actualCost => 25.25,
    :actualProg => 75.00,
    :statusNotes => "A Different Wall of Text"
    )
    assert(!activity.save, "It saves on TargetManp = " + targetManp.to_s)
  end

  ## TargetManp = integer
  it "should have TargetManp as an integer" do
    targetManp = 10.50
    activity = Activity.new(
    :name => "Aktivitat",
    :description => "Wall of Text",
    :phase => "Projektphasen",
    :startDate => Date.new(2013,03,26),
    :endDate => Date.new(2013,03,27),
    :targetManp => targetManp,
    :targetCost => 50.50,
    :notes => "Another Wall of Text",
    :actualManp => 10,
    :actualCost => 25.25,
    :actualProg => 75.00,
    :statusNotes => "A Different Wall of Text"
    )
    assert(!activity.save, "It saves on TargetManp = " + targetManp.to_s)
  end
  
  ## TargetManp = integer > 0
  it "should have TargetManp as an integer > 0" do
    targetManp = -5
    activity = Activity.new(
    :name => "Aktivitat",
    :description => "Wall of Text",
    :phase => "Projektphasen",
    :startDate => Date.new(2013,03,26),
    :endDate => Date.new(2013,03,27),
    :targetManp => targetManp,
    :targetCost => 50.50,
    :notes => "Another Wall of Text",
    :actualManp => 10,
    :actualCost => 25.25,
    :actualProg => 75.00,
    :statusNotes => "A Different Wall of Text"
    )
    assert(!activity.save, "It saves on TargetManp = " + targetManp.to_s)
  end

  ### TARGET COST
  
  ## TargetCost = decimal
  it "should have TargetCost as a decimal" do
    targetCost = "random"
    activity = Activity.new(
    :name => "Aktivitat",
    :description => "Wall of Text",
    :phase => "Projektphasen",
    :startDate => Date.new(2013,03,26),
    :endDate => Date.new(2013,03,27),
    :targetManp => 20,
    :targetCost => targetCost,
    :notes => "Another Wall of Text",
    :actualManp => 10,
    :actualCost => 25.25,
    :actualProg => 75.00,
    :statusNotes => "A Different Wall of Text"
    )
    assert(!activity.save, "It saves on TargetCost = " + targetCost.to_s)
  end

  ## TargetCost = decimal > 0
  it "should have TargetCost as a decimal > 0" do
    targetCost = -5
    activity = Activity.new(
    :name => "Aktivitat",
    :description => "Wall of Text",
    :phase => "Projektphasen",
    :startDate => Date.new(2013,03,26),
    :endDate => Date.new(2013,03,27),
    :targetManp => 20,
    :targetCost => targetCost,
    :notes => "Another Wall of Text",
    :actualManp => 10,
    :actualCost => 25.25,
    :actualProg => 75.00,
    :statusNotes => "A Different Wall of Text"
    )
    assert(!activity.save, "It saves on TargetCost = " + targetCost.to_s)
  end

  ### NOTES
  
  ## Notes can be empty
  it "can have empty Notes" do
    activity = Activity.new(
    :name => "Aktivitat",
    :description => "Wall of Text",
    :phase => "Projektphasen",
    :startDate => Date.new(2013,03,26),
    :endDate => Date.new(2013,03,27),
    :targetManp => 20,
    :targetCost => 50.50,
    :notes => "",
    :actualManp => 10,
    :actualCost => 25.25,
    :actualProg => 75.00,
    :statusNotes => "A Different Wall of Text"
    )
    assert(activity.save, "It saves on empty Notes")
  end
  
  ## Notes max = 600
  it "should not have Notes longer than 600 characters" do
    activity = Activity.new(
    :name => "Aktivitat",
    :description => "Wall of Text",
    :phase => "Projektphasen",
    :startDate => Date.new(2013,03,26),
    :endDate => Date.new(2013,03,27),
    :targetManp => 20,
    :targetCost => 50.50,
    :notes => (0...601).map{ ( 65+rand(26) ).chr }.join,
    :actualManp => 10,
    :actualCost => 25.25,
    :actualProg => 75.00,
    :statusNotes => "A Different Wall of Text"
    )
    assert(!activity.save, "It saves on Notes longer than 600 characters")
  end

  ### ACTUAL MAN POWER
  
  ## ActualManp = integer
  it "should have ActualManp as an integer" do
    actualManp = "random"
    activity = Activity.new(
    :name => "Aktivitat",
    :description => "Wall of Text",
    :phase => "Projektphasen",
    :startDate => Date.new(2013,03,26),
    :endDate => Date.new(2013,03,27),
    :targetManp => 20,
    :targetCost => 50.50,
    :notes => "Another Wall of Text",
    :actualManp => actualManp,
    :actualCost => 25.25,
    :actualProg => 75.00,
    :statusNotes => "A Different Wall of Text"
    )
    assert(!activity.save, "It saves on ActualManp = " + actualManp.to_s)
  end

  ## ActualManp = integer
  it "should have ActualManp as an integer" do
    actualManp = 10.50
    activity = Activity.new(
    :name => "Aktivitat",
    :description => "Wall of Text",
    :phase => "Projektphasen",
    :startDate => Date.new(2013,03,26),
    :endDate => Date.new(2013,03,27),
    :targetManp => 20,
    :targetCost => 50.50,
    :notes => "Another Wall of Text",
    :actualManp => actualManp,
    :actualCost => 25.25,
    :actualProg => 75.00,
    :statusNotes => "A Different Wall of Text"
    )
    assert(!activity.save, "It saves on ActualManp = " + actualManp.to_s)
  end
  
  ## ActualManp = integer > 0
  it "should have ActualManp as an integer > 0" do
    actualManp = -5
    activity = Activity.new(
    :name => "Aktivitat",
    :description => "Wall of Text",
    :phase => "Projektphasen",
    :startDate => Date.new(2013,03,26),
    :endDate => Date.new(2013,03,27),
    :targetManp => 20,
    :targetCost => 50.50,
    :notes => "Another Wall of Text",
    :actualManp => actualManp,
    :actualCost => 25.25,
    :actualProg => 75.00,
    :statusNotes => "A Different Wall of Text"
    )
    assert(!activity.save, "It saves on ActualManp = " + actualManp.to_s)
  end

  ### ACTUAL COST
  
  ## ActualCost = decimal
  it "should have ActualCost as a decimal" do
    actualCost = "random"
    activity = Activity.new(
    :name => "Aktivitat",
    :description => "Wall of Text",
    :phase => "Projektphasen",
    :startDate => Date.new(2013,03,26),
    :endDate => Date.new(2013,03,27),
    :targetManp => 20,
    :targetCost => 50.50,
    :notes => "Another Wall of Text",
    :actualManp => 10,
    :actualCost => actualCost,
    :actualProg => 75.00,
    :statusNotes => "A Different Wall of Text"
    )
    assert(!activity.save, "It saves on ActualCost = " + actualCost.to_s)
  end

  ## ActualCost = decimal > 0
  it "should have ActualCost as a decimal > 0" do
    actualCost = -5
    activity = Activity.new(
    :name => "Aktivitat",
    :description => "Wall of Text",
    :phase => "Projektphasen",
    :startDate => Date.new(2013,03,26),
    :endDate => Date.new(2013,03,27),
    :targetManp => 20,
    :targetCost => 50.50,
    :notes => "Another Wall of Text",
    :actualManp => 10,
    :actualCost => actualCost,
    :actualProg => 75.00,
    :statusNotes => "A Different Wall of Text"
    )
    assert(!activity.save, "It saves on ActualCost = " + actualCost.to_s)
  end

  ### ACTUAL PROGRESS
  
  ## ActualProg = float
  it "should have ActualProg as a float" do
    actualProg = "random"
    activity = Activity.new(
    :name => "Aktivitat",
    :description => "Wall of Text",
    :phase => "Projektphasen",
    :startDate => Date.new(2013,03,26),
    :endDate => Date.new(2013,03,27),
    :targetManp => 20,
    :targetCost => 50.50,
    :notes => "Another Wall of Text",
    :actualManp => 10,
    :actualCost => 25.25,
    :actualProg => actualProg,
    :statusNotes => "A Different Wall of Text"
    )
    assert(!activity.save, "It saves on ActualProg = " + actualProg.to_s)
  end

  ## ActualProg = float >= 0
  it "should have ActualProg as a float > 0" do
    actualProg = -5
    activity = Activity.new(
    :name => "Aktivitat",
    :description => "Wall of Text",
    :phase => "Projektphasen",
    :startDate => Date.new(2013,03,26),
    :endDate => Date.new(2013,03,27),
    :targetManp => 20,
    :targetCost => 50.50,
    :notes => "Another Wall of Text",
    :actualManp => 10,
    :actualCost => 25.25,
    :actualProg => actualProg,
    :statusNotes => "A Different Wall of Text"
    )
    assert(!activity.save, "It saves on ActualProg = " + actualProg.to_s)
  end

  ## ActualProg = float <= 100
  it "should have ActualProg as a float > 0" do
    actualProg = 100.50
    activity = Activity.new(
    :name => "Aktivitat",
    :description => "Wall of Text",
    :phase => "Projektphasen",
    :startDate => Date.new(2013,03,26),
    :endDate => Date.new(2013,03,27),
    :targetManp => 20,
    :targetCost => 50.50,
    :notes => "Another Wall of Text",
    :actualManp => 10,
    :actualCost => 25.25,
    :actualProg => actualProg,
    :statusNotes => "A Different Wall of Text"
    )
    assert(!activity.save, "It saves on ActualProg = " + actualProg.to_s)
  end

  ### STATUS NOTES
  
  ## Status Notes can be empty
  it "can have empty Status Notes" do
    activity = Activity.new(
    :name => "Aktivitat",
    :description => "Wall of Text",
    :phase => "Projektphasen",
    :startDate => Date.new(2013,03,26),
    :endDate => Date.new(2013,03,27),
    :targetManp => 20,
    :targetCost => 50.50,
    :notes => "Another Wall of Text",
    :actualManp => 10,
    :actualCost => 25.25,
    :actualProg => 75.00,
    :statusNotes => ""
    )
    assert(activity.save, "It saves on empty Status Notes")
  end
  
  ## Status Notes max = 600
  it "should not have Status Notes longer than 600 characters" do
    activity = Activity.new(
    :name => "Aktivitat",
    :description => "Wall of Text",
    :phase => "Projektphasen",
    :startDate => Date.new(2013,03,26),
    :endDate => Date.new(2013,03,27),
    :targetManp => 20,
    :targetCost => 50.50,
    :notes => "Another Wall of Text",
    :actualManp => 10,
    :actualCost => 25.25,
    :actualProg => 75.00,
    :statusNotes => (0...601).map{ ( 65+rand(26) ).chr }.join
    )
    assert(!activity.save, "It saves on Status Notes longer than 600 characters")
  end

  ### EXTRA
  
  ## Running Rspec remotely (RoR)
  ## Credit: Yong Hoon Lee
  ## Source: https://sites.google.com/a/eecs.berkeley.edu/cs169-sp13/project/setting-up-a-deployment-site
  after(:each) do
    Activity.delete_all
  end
end
