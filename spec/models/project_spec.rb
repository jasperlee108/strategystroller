require 'spec_helper'

describe Project do

  ### NOTE: Using ruby format, not Rspec
  
  def generate
    project = Project.new(
    :name => "Projekts",
    :description => "Projektbeschreibung",
    :startDate => Date.new(2013,03,27),
    :endDate => Date.new(2013,03,28),
    :duration => 5.5,
    :target_manp => 5,
    :target_cost => 10.5,
    :inplan => true,
    :compensation => true,
    :notes => "Anmerkungen",
    :actual_manp => 10,
    :actual_cost => 20.5,
    :status_prog => 75.5,
    :status_ms => 50,
    :status_manp => 10,
    :status_cost => 10.5,
    :status_global => 50.5,
    :status_notes => "Anmerkungen zum Status"
    )
    return project
  end
  
  ## Default
  it "should pass assert true sanity test" do
    assert(true, "Did not pass sanity check")
  end

  ## All Correct
  it "should behave correctly on good inputs" do
    project = generate()
    assert(project.save, "It won't save on good inputs")
  end

  ### NAME
  
  ## Name is not empty
  it "should not have empty Name" do
    name = ""
    project = generate()
    project.name = name
    assert(!project.save, "It saves on empty Name")
  end
  
  ## Name max = 80
  it "should not have Name longer than 80 characters" do
    name = (0...81).map{ ( 65+rand(26) ).chr }.join
    project = generate()
    project.name = name
    assert(!project.save, "It saves on Name longer than 80 characters")
  end

  ### DESCRIPTION
  
  ## Description can be empty
  it "can have empty Description" do
    description = ""
    project = generate()
    project.description = description
    assert(project.save, "It won't save on empty Description")
  end
  
  ## Description max = 600
  it "should not have Description longer than 600 characters" do
    description = (0...601).map{ ( 65+rand(26) ).chr }.join
    project = generate()
    project.description = description
    assert(!project.save, "It saves on Description longer than 600 characters")
  end

  ### DATE
  
  ## Start Date is valid
  it "should have valid Start Date" do
    startDate = "random"
    project = generate()
    project.startDate = startDate
    assert(!project.save, "It saves on invalid Start Date")
  end

  ## End Date is valid
  it "should have valid End Date" do
    endDate = "random"
    project = generate()
    project.endDate = endDate
    assert(!project.save, "It saves on invalid End Date")
  end

  ## Start Date before End Date
  it "should have Start Date before End Date" do
    startDate = Date.new(2013,03,28)
    endDate = Date.new(2013,03,27)
    project = generate()
    project.startDate = startDate
    project.endDate = endDate
    assert(!project.save, "It saves on End Date before Start Date")
  end

  ## Date doesn't have February 30th
  # NOTE: date is in string, the validator will check its correctness,
  # if not, it will error out before even reaching the validator
  it "should have real Date" do
    startDate = "2013-02-30"
    project = generate()
    project.startDate = startDate
    assert(!project.save, "It saves on non existence Date")
  end

  ### DURATION
  
  ## Duration = float
  it "should have Duration as a float" do
    duration = "random"
    project = generate()
    project.duration = duration
    assert(!project.save, "It saves on Duration = " + duration.to_s)
  end

  ## Duration = float >= 0
  it "should have Duration as a float >= 0" do
    duration = -5
    project = generate()
    project.duration = duration
    assert(!project.save, "It saves on Duration = " + duration.to_s)
  end

  ### TARGET MAN POWER
  
  ## TargetManp = integer
  it "should have TargetManp as an integer" do
    targetManp = "random"
    project = generate()
    project.target_manp = targetManp
    assert(!project.save, "It saves on TargetManp = " + targetManp.to_s)
  end

  ## TargetManp = integer
  it "should have TargetManp as an integer" do
    targetManp = 10.50
    project = generate()
    project.target_manp = targetManp
    assert(!project.save, "It saves on TargetManp = " + targetManp.to_s)
  end
  
  ## TargetManp = integer >= 0
  it "should have TargetManp as an integer >= 0" do
    targetManp = -5
    project = generate()
    project.target_manp = targetManp
    assert(!project.save, "It saves on TargetManp = " + targetManp.to_s)
  end

  ### TARGET COST
  
  ## TargetCost = decimal
  it "should have TargetCost as a decimal" do
    targetCost = "random"
    project = generate()
    project.target_cost = targetCost
    assert(!project.save, "It saves on TargetCost = " + targetCost.to_s)
  end

  ## TargetCost = decimal >= 0
  it "should have TargetCost as a decimal >= 0" do
    targetCost = -5
    project = generate()
    project.target_cost = targetCost
    assert(!project.save, "It saves on TargetCost = " + targetCost.to_s)
  end

  ### INPLAN
  
  ## Inplan = false
  ## True case is checked in All Correct test
  it "can have Inplan be false" do
    inplan = false
    project = generate()
    project.inplan = inplan
    assert(project.save, "It won't save on Inplan being false")
  end

  ### COMPENSATION
  
  ## Compensation = false
  ## True case is checked in All Correct test
  it "can have Compensation be false" do
    compensation = false
    project = generate()
    project.compensation = compensation
    assert(project.save, "It won't save on Compensation being false")
  end

  ### NOTES
  
  ## Notes can be empty
  it "can have empty Notes" do
    notes = ""
    project = generate()
    project.notes = notes
    assert(project.save, "It won't save on empty Notes")
  end
  
  ## Notes max = 600
  it "should not have Notes longer than 600 characters" do
    notes = (0...601).map{ ( 65+rand(26) ).chr }.join
    project = generate()
    project.notes = notes
    assert(!project.save, "It saves on Notes longer than 600 characters")
  end

  ### ACTUAL MAN POWER
  
  ## ActualManp = integer
  it "should have ActualManp as an integer" do
    actualManp = "random"
    project = generate()
    project.actual_manp = actualManp
    assert(!project.save, "It saves on ActualManp = " + actualManp.to_s)
  end

  ## ActualManp = integer
  it "should have ActualManp as an integer" do
    actualManp = 10.50
    project = generate()
    project.actual_manp = actualManp
    assert(!project.save, "It saves on ActualManp = " + actualManp.to_s)
  end
  
  ## ActualManp = integer >= 0
  it "should have ActualManp as an integer >= 0" do
    actualManp = -5
    project = generate()
    project.actual_manp = actualManp
    assert(!project.save, "It saves on ActualManp = " + actualManp.to_s)
  end

  ### ACTUAL COST
  
  ## ActualCost = decimal
  it "should have ActualCost as a decimal" do
    actualCost = "random"
    project = generate()
    project.actual_cost = actualCost
    assert(!project.save, "It saves on ActualCost = " + actualCost.to_s)
  end

  ## ActualCost = decimal >= 0
  it "should have ActualCost as a decimal >= 0" do
    actualCost = -5
    project = generate()
    project.actual_cost = actualCost
    assert(!project.save, "It saves on ActualCost = " + actualCost.to_s)
  end

  ### STATUS PROGRESS
  
  ## StatusProg = float
  it "should have StatusProg as a float" do
    statusProg = "random"
    project = generate()
    project.status_prog = statusProg
    assert(!project.save, "It saves on StatusProg = " + statusProg.to_s)
  end

  ## StatusProg = float >= 0
  it "should have StatusProg as a float >= 0" do
    statusProg = -5
    project = generate()
    project.status_prog = statusProg
    assert(!project.save, "It saves on StatusProg = " + statusProg.to_s)
  end

  ## StatusProg = float <= 100
  it "should have StatusProg as a float <= 100" do
    statusProg = 100.50
    project = generate()
    project.status_prog = statusProg
    assert(!project.save, "It saves on StatusProg = " + statusProg.to_s)
  end

  ### STATUS MILESTONE
  
  ## StatusMs = integer
  it "should have StatusMs as a integer" do
    statusMs = "random"
    project = generate()
    project.status_ms = statusMs
    assert(!project.save, "It saves on StatusMs = " + statusMs.to_s)
  end

  ## StatusMs = integer >= 0
  it "should have StatusMs as a integer >= 0" do
    statusMs = -5
    project = generate()
    project.status_ms = statusMs
    assert(!project.save, "It saves on StatusMs = " + statusMs.to_s)
  end

  ## StatusMs = integer <= 100
  it "should have StatusMs as a integer <= 100" do
    statusMs = 100.50
    project = generate()
    project.status_ms = statusMs
    assert(!project.save, "It saves on StatusMs = " + statusMs.to_s)
  end

  ### STATUS MAN POWER
  
  ## StatusManp = integer
  it "should have StatusManp as a integer" do
    statusManp = "random"
    project = generate()
    project.status_manp = statusManp
    assert(!project.save, "It saves on StatusManp = " + statusManp.to_s)
  end

  ## StatusManp = integer >= 0
  it "should have StatusManp as a integer >= 0" do
    statusManp = -5
    project = generate()
    project.status_manp = statusManp
    assert(!project.save, "It saves on StatusManp = " + statusManp.to_s)
  end

  ## StatusManp = integer <= 100
  it "should have StatusManp as a integer <= 100" do
    statusManp = 100.50
    project = generate()
    project.status_manp = statusManp
    assert(!project.save, "It saves on StatusManp = " + statusManp.to_s)
  end

  ### STATUS COST
  
  ## StatusCost = float
  it "should have StatusCost as a float" do
    statusCost = "random"
    project = generate()
    project.status_cost = statusCost
    assert(!project.save, "It saves on StatusCost = " + statusCost.to_s)
  end

  ## StatusCost = float >= 0
  it "should have StatusCost as a float >= 0" do
    statusCost = -5
    project = generate()
    project.status_cost = statusCost
    assert(!project.save, "It saves on StatusCost = " + statusCost.to_s)
  end

  ## StatusCost = float <= 100
  it "should have StatusCost as a float <= 100" do
    statusCost = 100.50
    project = generate()
    project.status_cost = statusCost
    assert(!project.save, "It saves on StatusCost = " + statusCost.to_s)
  end

  ### STATUS GLOBAL
  
  ## StatusGlobal = float
  it "should have StatusGlobal as a float" do
    statusGlobal = "random"
    project = generate()
    project.status_global = statusGlobal
    assert(!project.save, "It saves on StatusGlobal = " + statusGlobal.to_s)
  end

  ## StatusGlobal = float >= 0
  it "should have StatusGlobal as a float >= 0" do
    statusGlobal = -5
    project = generate()
    project.status_global = statusGlobal
    assert(!project.save, "It saves on StatusGlobal = " + statusGlobal.to_s)
  end

  ## StatusGlobal = float <= 100
  it "should have StatusGlobal as a float <= 100" do
    statusGlobal = 100.50
    project = generate()
    project.status_global = statusGlobal
    assert(!project.save, "It saves on StatusGlobal = " + statusGlobal.to_s)
  end

  ### STATUS NOTES
  
  ## Status Notes can be empty
  it "can have empty Status Notes" do
    statusNotes = ""
    project = generate()
    project.status_notes = statusNotes
    assert(project.save, "It won't save on empty Status Notes")
  end
  
  ## Status Notes max = 600
  it "should not have Status Notes longer than 600 characters" do
    statusNotes = (0...601).map{ ( 65+rand(26) ).chr }.join
    project = generate()
    project.status_notes = statusNotes
    assert(!project.save, "It saves on Status Notes longer than 600 characters")
  end

  ### EXTRA
  
  ## Running Rspec remotely (RoR)
  ## Credit: Yong Hoon Lee
  ## Source: https://sites.google.com/a/eecs.berkeley.edu/cs169-sp13/project/setting-up-a-deployment-site
  after(:each) do
    Project.delete_all
  end
end
