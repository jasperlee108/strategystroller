require 'spec_helper'

describe Project do

  ### NOTE: Using ruby format, not Rspec
  ### TODO: user_ids for "team" is not yet tested
  
  def generate
    project = Project.new(
    :name => "Projekts",
    :description => "Projektbeschreibung",
    :startDate => Date.new(2013,03,27),
    :endDate => Date.new(2014,03,28),
    :actual_duration => 15,
    :target_duration => 52,
    :target_manp => 5,
    :target_cost => 10.5,
    :inplan => true,
    :compensation => true,
    :notes => "Anmerkungen",
    :actual_manp => 10,
    :actual_cost => 20.5,
    :status_prog => 75.5,
    :status_ms => {-1=>0, 1=>0, 2=>2, 3=>0, 4=>1},
    :status_manp => 10.0,
    :status_cost => 10.5,
    :status_global => 50.5,
    :status_notes => "Anmerkungen zum Status",
    :indicator_id => 1,
    :head_id => 1,
    :steer_id => 1,
    :yearly_target_manp => {}, # kept as an example: {2013 => BigDecimal(5.57,10), 2014 => BigDecimal(7.57,10)},
    :yearly_target_cost => {}, # kept as an example: {2013 => BigDecimal(25.25,10), 2014 => BigDecimal(38.07,10)},
    :team => "James Bond, Andy Warhol",
    :short_name => "Shorter name"
    )
    return project
  end

  def gen_activity
    Activity.new(
        :name => "Aktivitat",
        :description => "Wall of Text",
        :phase => Activity::PREREQUISITES_FULFILLED,
        :startDate => Date.new(2013,07,02),  # If these dates change, the yearly_ tests will fail.
        :endDate => Date.new(2014,07,03),
        :targetManp => 11,
        :targetCost => 50.50,
        :notes => "Another Wall of Text",
        :actualManp => 15,
        :actualCost => 25.25,
        :actualProg => Activity::IN_PROGRESS,
        :statusNotes => "A Different Wall of Text",
        :project_id => 1,
        :team => "James Bond, Andy Warhol",
        :short_name => "Shorter name"
    )
  end

  def gen_with_children
    project = generate()
    activity1 = gen_activity
    activity2 = Activity.new(   #activity for a different project
        :name => "Aktivitat2",
        :description => "Wall of Text2",
        :phase => Activity::PREREQUISITES_FULFILLED,
        :startDate => Date.new(2013,03,26),
        :endDate => Date.new(2013,03,27),
        :targetManp => 20,
        :targetCost => 50.50,
        :notes => "Another Wall of Text",
        :actualManp => 3,
        :actualCost => 9.50,
        :actualProg => Activity::IN_PROGRESS,
        :statusNotes => "A Different Wall of Text",
        :project_id => 2,
        :team => "James Warhol",
        :short_name => "Shorter name"
    )
    activity3 = Activity.new(
        :name => "Aktivitat3",
        :description => "Wall of Text3",
        :phase => Activity::PREREQUISITES_FULFILLED,
        :startDate => Date.new(2014,07,2),  # If these dates change, the yearly_ tests will fail.
        :endDate => Date.new(2014,07,12),
        :targetManp => 2,
        :targetCost => 12.75,
        :notes => "Another Wall of Text3",
        :actualManp => 15,
        :actualCost => 25.25,
        :actualProg => Activity::IN_PROGRESS,
        :statusNotes => "A Different Wall of Text3",
        :project_id => 1,
        :team => "James Bond3, Andy Warhol3",
        :short_name => "Shorter name"
    )
    activity1.save()
    activity2.save()
    activity3.save()
    project.actual_cost = 0
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

  ### actual_duration

  ## actual_duration is not empty
  it "should not have empty actual_duration" do
    actual_duration = nil
    project = generate()
    project.actual_duration = actual_duration
    assert(!project.save, "It saves on empty actual_duration")
  end

  ## actual_duration = integer
  it "should have actual_duration as an integer" do
    actual_duration = "random"
    project = generate()
    project.actual_duration = actual_duration
    assert(!project.save, "It saves on actual_duration = " + actual_duration.to_s)
  end

  ## actual_duration = integer >= 0
  it "should have actual_duration as an integer >= 0" do
    actual_duration = -5
    project = generate()
    project.actual_duration = actual_duration
    assert(!project.save, "It saves on actual_duration = " + actual_duration.to_s)
  end

  ### target_duration

  ## target_duration is not empty
  it "should not have empty target_duration" do
    target_duration = nil
    project = generate()
    project.target_duration = target_duration
    assert(!project.save, "It saves on empty target_duration")
  end

  ## target_duration = integer
  it "should have target_duration as an integer" do
    target_duration = "random"
    project = generate()
    project.target_duration = target_duration
    assert(!project.save, "It saves on target_duration = " + target_duration.to_s)
  end

  ## target_duration = integer >= 0
  it "should have target_duration as an integer >= 0" do
    target_duration = -5
    project = generate()
    project.target_duration = target_duration
    assert(!project.save, "It saves on target_duration = " + target_duration.to_s)
  end

  ### TARGET MAN POWER
  
  ## TargetManp is not empty
  it "should not have empty TargetManp" do
    targetManp = nil
    project = generate()
    project.target_manp = targetManp
    assert(!project.save, "It saves on empty TargetManp")
  end
  
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
  
  ## TargetCost is not empty
  it "should not have empty TargetCost" do
    targetCost = nil
    project = generate()
    project.target_cost = targetCost
    assert(!project.save, "It saves on empty TargetCost")
  end
  
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
  
  ## ActualManp is not empty
  it "should not have empty ActualManp" do
    actualManp = nil
    project = generate()
    project.actual_manp = actualManp
    assert(!project.save, "It saves on empty ActualManp")
  end
  
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
  
  ## ActualCost is not empty
  it "should not have empty ActualCost" do
    actualCost = nil
    project = generate()
    project.actual_cost = actualCost
    assert(!project.save, "It saves on empty ActualCost")
  end
  
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
  
  ## StatusProg is not empty
  it "should not have empty StatusProg" do
    statusProg = nil
    project = generate()
    project.status_prog = statusProg
    assert(!project.save, "It saves on empty StatusProg")
  end
  
  ## StatusProg = decimal
  it "should have StatusProg as a decimal" do
    statusProg = "random"
    project = generate()
    project.status_prog = statusProg
    assert(!project.save, "It saves on StatusProg = " + statusProg.to_s)
  end

  ## StatusProg = decimal >= 0
  it "should have StatusProg as a decimal >= 0" do
    statusProg = -5
    project = generate()
    project.status_prog = statusProg
    assert(!project.save, "It saves on StatusProg = " + statusProg.to_s)
  end

  ### STATUS MILESTONE
  
  ## StatusMs is not empty
  it "should not have empty StatusMs" do
    statusMs = nil
    project = generate()
    project.status_ms = statusMs
    assert(!project.save, "It saves on empty StatusMs")
  end
  
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

  ## StatusMs = integer <= 8
  it "should have StatusMs as a integer >= 0" do
    statusMs = 9
    project = generate()
    project.status_ms = statusMs
    assert(!project.save, "It saves on StatusMs = " + statusMs.to_s)
  end

  ### STATUS MAN POWER
  
  ## StatusManp is not empty
  it "should not have empty StatusManp" do
    statusManp = nil
    project = generate()
    project.status_manp = statusManp
    assert(!project.save, "It saves on empty StatusManp")
  end
  
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

  ### STATUS COST
  
  ## StatusCost is not empty
  it "should not have empty StatusCost" do
    statusCost = nil
    project = generate()
    project.status_cost = statusCost
    assert(!project.save, "It saves on empty StatusCost")
  end
  
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

  ### STATUS GLOBAL
  
  ## StatusGlobal is not empty
  it "should not have empty StatusGlobal" do
    statusGlobal = nil
    project = generate()
    project.status_global = statusGlobal
    assert(!project.save, "It saves on empty StatusGlobal")
  end
  
  ## StatusGlobal = decimal
  it "should have StatusGlobal as a decimal" do
    statusGlobal = "random"
    project = generate()
    project.status_global = statusGlobal
    assert(!project.save, "It saves on StatusGlobal = " + statusGlobal.to_s)
  end

  ## StatusGlobal = decimal >= 0
  it "should have StatusGlobal as a decimal >= 0" do
    statusGlobal = -5
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

  ### TEAM
  
  ## Team Notes can be empty
  it "can have empty Team" do
    team = ""
    project = generate()
    project.team = team
    assert(project.save, "It won't save on empty Team")
  end
  
  ## Team Notes max = 600
  it "should not have Team longer than 600 characters" do
    team = (0...601).map{ ( 65+rand(26) ).chr }.join
    project = generate()
    project.team = team
    assert(!project.save, "It saves on Team longer than 600 characters")
  end

  ### SHORT NAME
  
  ## Short Name is not empty
  it "should not have empty Short Name" do
    short_name = ""
    project = generate()
    project.short_name = short_name
    assert(!project.save, "It saves on empty Short Name")
  end
  
  ## Short Name max = 30
  it "should not have Short Name longer than 30 characters" do
    short_name = (0...31).map{ ( 65+rand(26) ).chr }.join
    project = generate()
    project.short_name = short_name
    assert(!project.save, "It saves on Short Name longer than 30 characters")
  end

  ### update_actual_cost
  it 'should update its cost using only its children' do
    project = gen_with_children()
    project.save()
    project_in_table = Project.find(1)
    project_in_table.update_actual_cost()
    assert(project_in_table.actual_cost == 50.50, "Project's cost = #{project_in_table.actual_cost}, not 50.50 as it should.")
  end

  it 'can update it\'s cost even if it has no children' do
    project = generate()
    project.save()
    project_in_table = Project.find(1)
    project_in_table.update_actual_cost()
    assert(project_in_table.actual_cost == 0.0, "Project's cost = #{project_in_table.actual_cost}, not 0.0 as it should.")
  end

  ### update_actual_manp
  it 'should update its manp using only its children' do
    project = gen_with_children()
    project.save()
    project_in_table = Project.find(1)
    project_in_table.update_actual_manp()
    assert(project_in_table.actual_manp == 30, "Project's manp = #{project_in_table.actual_manp}, not 30 as it should.")
  end

  it 'can update it\'s manp even if it has no children' do
    project = generate()
    project.save()
    project_in_table = Project.find(1)
    project_in_table.update_actual_manp()
    assert(project_in_table.actual_manp == 0.0, "Project's manp = #{project_in_table.actual_manp}, not 0 as it should.")
  end

  ### YEARLY_TARGET_MANP

  # :yearly_target_manp will save an empty hash.
  it 'will allow an empty target_manp hash' do
    project = generate()
    project.yearly_target_manp = {}
    assert(project.save, "yearly_target_manp is not being allowed to be an empty hash")
  end

  # :yearly_target_manp will not allow a non-integer year.
  it 'will not allow a non-integer year' do
    project = generate()
    project.yearly_target_manp = {2012 => BigDecimal(5.5, 6), "2013" => BigDecimal(5.5, 6)}
    assert(!project.save, "yearly_target_manp is saving with a non-integer year: #{project.yearly_target_manp.keys[1]}")
  end

  # :yearly_target_manp will not save a non-hash.
  it 'will not allow a non-hash yearly_target_manp' do
    project = generate()
    project.yearly_target_manp = []
    assert(!project.save, "yearly_target_manp is allowing a non-hash")
  end

  # :yearly_target_manp will not allow a non-BigDecimal manp.
  it 'will not allow a non-BigDecimal manp' do
    project = generate()
    project.yearly_target_manp = {2012 => BigDecimal(5.5, 6), 2013 => 5.5 }
    assert(!project.save, "yearly_target_manp is saving with a non-BigDecimal manp: #{project.yearly_target_manp[2013]}")
  end

  # :yearly_target_manp will not allow a negative manp.
  it 'will not allow a negative manp' do
    project = generate()
    project.yearly_target_manp = {2012 => BigDecimal(5.5, 6), 2013 => BigDecimal(-5.5, 6)}
    assert(!project.save, "yearly_target_manp is saving with a negative manp: #{project.yearly_target_manp[2013]}")
  end

  # :yearly_target_manp will not allow a year before startDate.
  it 'will not allow a year before startDate' do
    project = generate()
    project.yearly_target_manp = {2011 => BigDecimal(5.5, 6), 2013 => BigDecimal(5.5, 6)}
    assert(!project.save, "yearly_target_manp is saving with a year before startDate: #{project.yearly_target_manp.keys[0]}")
  end

  # :yearly_target_manp will not allow a year after endDate.
  it 'will not allow a year before startDate' do
    project = generate()
    project.yearly_target_manp = {2012 => BigDecimal(5.5, 6), 2014 => BigDecimal(5.5, 6)}
    assert(!project.save, "yearly_target_manp is saving with a year after endDate: #{project.yearly_target_manp.keys[1]}")
  end

  ### YEARLY_TARGET_COST

  # :yearly_target_cost will save an empty hash.
  it 'will allow an empty target_cost hash' do
    project = generate()
    project.yearly_target_cost = {}
    assert(project.save, "yearly_target_cost is not being allowed to be an empty hash")
  end

  # :yearly_target_cost will not allow a non-integer year.
  it 'will not allow a non-integer year' do
    project = generate()
    project.yearly_target_cost = {2012 => BigDecimal(5.5, 6), "2013" => BigDecimal(5.5, 6)}
    assert(!project.save, "yearly_target_cost is saving with a non-integer year: #{project.yearly_target_cost.keys[1]}")
  end

  # :yearly_target_cost will not save a non-hash.
  it 'will not allow a non-hash yearly_target_cost' do
    project = generate()
    project.yearly_target_cost = []
    assert(!project.save, "yearly_target_cost is allowing a non-hash")
  end

  # :yearly_target_cost will not allow a non-BigDecimal cost.
  it 'will not allow a non-BigDecimal cost' do
    project = generate()
    project.yearly_target_cost = {2012 => BigDecimal(5.5, 6), 2013 => 5.5 }
    assert(!project.save, "yearly_target_cost is saving with a non-BigDecimal cost: #{project.yearly_target_cost[2013]}")
  end

  # :yearly_target_cost will not allow a negative cost.
  it 'will not allow a negative cost' do
    project = generate()
    project.yearly_target_cost = {2012 => BigDecimal(5.5, 6), 2013 => BigDecimal(-5.5, 6)}
    assert(!project.save, "yearly_target_cost is saving with a negative cost: #{project.yearly_target_cost[2013]}")
  end

  # :yearly_target_cost will not allow a year before startDate.
  it 'will not allow a year before startDate' do
    project = generate()
    project.yearly_target_cost = {2011 => BigDecimal(5.5, 6), 2013 => BigDecimal(5.5, 6)}
    assert(!project.save, "yearly_target_cost is saving with a year before startDate: #{project.yearly_target_cost.keys[0]}")
  end

  # :yearly_target_cost will not allow a year after endDate.
  it 'will not allow a year after endDate' do
    project = generate()
    project.yearly_target_cost = {2012 => BigDecimal(5.5, 6), 2014 => BigDecimal(5.5, 6)}
    assert(!project.save, "yearly_target_cost is saving with a year after endDate: #{project.yearly_target_cost.keys[1]}")
  end

  ### STAUS_MS    TODO
  it 'will not allow a non-hash'do
    project = generate
    project.status_ms = [0,0,0,0,0]
    assert(!project.save, "Project saved with an empty hash.")
  end

  it 'will not allow an empty hash'do
    project = generate
    project.status_ms = {}
    assert(!project.save, "Project saved with an empty hash.")
  end

  it 'will not save if there is a phase not in Activity::PHASES' do
    project = generate
    project.status_ms = {-1=>0, 1=>0, 2=>0, 3=>0, 22=>0}
    assert(!project.save, "Project saved with a phase not in Activity::PHASES.")
  end

  it 'will not save if there is a progress not in Activity::PROGRESS' do
    project = generate
    project.status_ms = {-1=>0, 1=>0, 2=>0, 3=>0, 4=>-1}
    assert(!project.save, "Project saved with a project not in Activity::PROJECT.")
  end

  it 'will not save if there is not pair entry for each phase in Activity::PHASES' do
    project = generate
    project.status_ms = { 1=>0, 2=>0, 3=>0, 4=>0 }
    assert(!project.save, "Project saved with a project not in Activity::PROJECT.")
  end

  it 'will not save if Activity::PROJECT_MANAGEMENT hase a nonzero phase' do
    project = generate
    project.status_ms = {-1=>1, 1=>0, 2=>0, 3=>0, 4=>0 }
    assert(!project.save, "Project saved with PROJECT_MANAGEMENT with having a nonzero value")
  end


  ### INITIALIZED_YEAR_HASH

  #the correct hash is returned for a project that spans one year
  it 'will return a one-element hash for a project that is in a single year' do
    project = generate
    project.startDate = Date.new(2013, 3, 7)
    project.endDate = Date.new(2013, 6, 9)
    i_y_hash = project.initialized_year_hash
    assert(i_y_hash == {2013 => BigDecimal(0.0, 10)}, "The wrong hash was returned. Instead of {2013=>BD0.0}, got: #{i_y_hash}")
  end

  #the correct hash is returned for a project that spans two years
  it 'will return a two-element hash for a project that spans two years' do
    project = generate
    project.startDate = Date.new(2013, 3, 7)
    project.endDate = Date.new(2014, 6, 9)
    i_y_hash = project.initialized_year_hash
    assert(i_y_hash == {2013 => BigDecimal(0.0, 10), 2014 => BigDecimal(0.0, 10)}, "The wrong hash was returned. Instead of {2013=>BD0.0,2014=>BD0.0}, got: #{i_y_hash}")
  end

  #the correct hash is returned for a project that spans three years
  it 'will return a three-element hash for a project that spans three years' do
    project = generate
    project.startDate = Date.new(2013, 3, 7)
    project.endDate = Date.new(2015, 6, 9)
    i_y_hash = project.initialized_year_hash
    assert(i_y_hash == {2013 => BigDecimal(0.0, 10), 2014 => BigDecimal(0.0, 10), 2015 => BigDecimal(0.0, 10)}, "The wrong hash was returned. Instead of {2013=>BD0.0,2014=>BD0.0,2015=>BD0.0}, got: #{i_y_hash}")
  end

  ### ACTIVITY_YEAR_FRACTIONS_HASH

  it 'will return a one-element hash for an activity that is in a single year' do
    activity = gen_activity
    project = generate
    activity.startDate = Date.new(2013, 3, 7)
    activity.endDate = Date.new(2013, 6, 9)
    ayf_hash = project.activity_year_fractions_hash(activity)
    assert(ayf_hash == {2013 => Rational('1/1')}, "The wrong hash was returned. Instead of {2013=>R(1/1)}, got: #{ayf_hash}")
  end

  it 'will return a two-element 50/50 hash for an activity that is split evenly across two years' do
    activity = gen_activity
    project = generate
    activity.startDate = Date.new(2013, 12, 1)
    activity.endDate = Date.new(2014, 2, 1)
    ayf_hash = project.activity_year_fractions_hash(activity)
    assert(ayf_hash == {2013 => Rational('1/2'), 2014 => Rational('1/2')}, "The wrong hash was returned. Instead of {2013=>R(1/2),2014=>R(1/2)}, got: #{ayf_hash}")
  end

  it 'will return a three-element hash for an activity that is split across three years' do
    activity = gen_activity
    project = generate
    activity.startDate = Date.new(2013, 12, 1)
    activity.endDate = Date.new(2015, 2, 1)
    ayf_hash = project.activity_year_fractions_hash(activity)
    assert(ayf_hash == {2013 => Rational('31/427'), 2014 => Rational('365/427'),2015 => Rational('31/427')}, "The wrong hash was returned. Instead of {2013=>R(31/427), 2014=>R(365/427), 2015=>R(31/427)}, got: #{ayf_hash}")
  end
  
  ### UPDATE_YEARLY_TARGET_COST

  it 'properly calculates the distribution of target cost across evenly split years' do
    project = gen_with_children
    project.startDate = Date.new(2013,03,27)
    project.endDate = Date.new(2014,03,28)
    project.save
    proj_in_table = Project.find(1)
    proj_in_table.update_yearly_target_cost
    assert(proj_in_table.yearly_target_cost.values == [25.25, 38], "Failed to correctly calculate yearly_target_cost, instead of {2013=>BD(25.25),2014=>BD(38.00)} got: #{proj_in_table.yearly_target_cost}")
  end

  it 'properly calculates the distribution of target cost only in one year' do
    project = gen_with_children
    project.startDate = Date.new(2013,03,27)
    project.endDate = Date.new(2013,03,29)
    project.save
    proj_in_table = Project.find(1)
    proj_in_table.update_yearly_target_cost
    assert(proj_in_table.yearly_target_cost.values == [25.25], "Failed to correctly calculate yearly_target_cost, instead of {2013=>BD(25.25)} got: #{proj_in_table.yearly_target_cost}")
  end

  it 'properly calculates the distribution of target cost if there are no activities in the given years.' do
    project = gen_with_children
    project.startDate = Date.new(2015,03,27)
    project.endDate = Date.new(2016,03,29)
    project.save
    proj_in_table = Project.find(1)
    proj_in_table.update_yearly_target_cost
    assert(proj_in_table.yearly_target_cost == {2015 => BigDecimal(0.0,10), 2016 => BigDecimal(0.0,10)}, "Failed to correctly calculate yearly_target_cost, instead of {2015=>BD(0.0),2016=>BD0.0} got: #{proj_in_table.yearly_target_cost}")
  end

  ### UPDATE_YEARLY_TARGET_MANP

  it 'properly calculates the distribution of target manp across evenly split years' do
    project = gen_with_children
    project.startDate = Date.new(2013,03,27)
    project.endDate = Date.new(2014,03,28)
    project.save
    proj_in_table = Project.find(1)
    proj_in_table.update_yearly_target_manp
    assert(proj_in_table.yearly_target_manp.values == [5.5, 7.5], "Failed to correctly calculate yearly_target_manp, instead of {2013=>BD(5.5),2014=>BD(7.5)} got: #{proj_in_table.yearly_target_manp}")
  end

  it 'properly calculates the distribution of target manp only in one year' do
    project = gen_with_children
    project.startDate = Date.new(2013,03,27)
    project.endDate = Date.new(2013,03,29)
    project.save
    proj_in_table = Project.find(1)
    proj_in_table.update_yearly_target_manp
    assert(proj_in_table.yearly_target_manp.values == [5.5], "Failed to correctly calculate yearly_target_manp, instead of {2013=>BD(5.5)} got: #{proj_in_table.yearly_target_manp}")
  end

  it 'properly calculates the distribution of target manp if there are no activities in the given years.' do
    project = gen_with_children
    project.startDate = Date.new(2015,03,27)
    project.endDate = Date.new(2016,03,29)
    project.save
    proj_in_table = Project.find(1)
    proj_in_table.update_yearly_target_manp
    assert(proj_in_table.yearly_target_manp == {2015 => BigDecimal(0.0,10), 2016 => BigDecimal(0.0,10)}, "Failed to correctly calculate yearly_target_manp, instead of {2015=>BD(0.0),2016=>BD0.0} got: #{proj_in_table.yearly_target_manp}")
  end

  ### UPDATE_TARGET_DURATION

  it 'correctly calculates the target_duration span of one day separated' do
    project = gen_with_children
    project.startDate = Date.new(2013,03,27)
    project.endDate = Date.new(2013,03,28)
    project.save
    proj_in_table = Project.find(1)
    proj_in_table.update_target_duration
    assert(proj_in_table.target_duration == 1, "Failed to correctly calculate target_duration, instead of 1 got: #{proj_in_table.target_duration}")
  end

  it 'correctly calculates the target_duration span of one year separated' do
    project = gen_with_children
    project.startDate = Date.new(2013,7,2)
    project.endDate = Date.new(2014,7,2)
    project.save
    proj_in_table = Project.find(1)
    proj_in_table.update_target_duration
    assert(proj_in_table.target_duration == 365, "Failed to correctly calculate target_duration, instead of 365 got: #{proj_in_table.target_duration}")
  end

  ### UPDATE_ACTUAL_DURATION

  it 'correctly calculates the actual_duration span of one day separated' do
    project = gen_with_children
    project.startDate = Date.today.prev_day
    project.endDate = Date.today.next_year  # shouldn't matter for the test as long as this provides a valid start/end combination so the record will save.
    project.save
    proj_in_table = Project.find(1)
    proj_in_table.update_actual_duration
    assert(proj_in_table.actual_duration == 1, "Failed to correctly calculate actual_duration, instead of 1 got: #{proj_in_table.actual_duration}")
  end

  it 'correctly calculates the actual_duration span of one year separated' do
    project = gen_with_children
    project.startDate = Date.today.prev_year
    project.endDate = Date.today.next_year  # shouldn't matter for the test as long as this provides a valid start/end combination so the record will save.
    project.save
    proj_in_table = Project.find(1)
    proj_in_table.update_actual_duration
    assert(proj_in_table.actual_duration == Date.today - Date.today.prev_year, "Failed to correctly calculate actual_duration, instead of 365 got: #{proj_in_table.actual_duration}")
  end
  
  ### UPDATE_STATUS_PROG
  it 'correctly calculates the status_prog of 1/2 done' do
    project = gen_with_children
    project.startDate = Date.today.prev_year.prev_year.prev_year.prev_year #years in multiples of 4 to deal with leap-year issues
    project.endDate = Date.today.next_year.next_year.next_year.next_year
    project.save
    proj_in_table = Project.find(1)
    proj_in_table.update_actual_duration
    proj_in_table.update_target_duration
    proj_in_table.update_status_prog
    assert(proj_in_table.status_prog == BigDecimal(1461, 10)/ BigDecimal(2922,10), "Failed to correctly calculate status_prog, instead of 1/2 got: #{proj_in_table.status_prog}")
  end

  it 'correctly calculates the status_prog of 100% done' do
    project = gen_with_children
    project.startDate = Date.yesterday
    project.endDate = Date.today
    project.save
    proj_in_table = Project.find(1)
    proj_in_table.update_actual_duration
    proj_in_table.update_target_duration
    proj_in_table.update_status_prog
    assert(proj_in_table.status_prog == 1, "Failed to correctly calculate status_prog, instead of 1 got: #{proj_in_table.status_prog}")
  end

  ### UPDATE_STATUS_MANP
  it 'correctly updates the status_manp' do
    project = generate
    project.actual_manp = 10
    project.target_manp = 20
    project.save
    proj_in_table = Project.find(1)
    proj_in_table.update_status_manp
    assert(proj_in_table.status_manp == BigDecimal(0.5, 10), "Failed to correctly calculate status_manp, instead of 0.5 got: #{proj_in_table.status_manp}")
  end

  it 'correctly sets status_manp if target_manp == zero' do
    project = generate
    project.target_manp = 0
    project.save
    proj_in_table = Project.find(1)
    proj_in_table.update_status_manp
    assert(proj_in_table.status_manp == BigDecimal(0, 10), "Failed to correctly set status_manp, instead of 0 got: #{proj_in_table.status_manp}")
  end


  ### UPDATE_STATUS_COST
  it 'correctly updates the status_cost' do
    project = generate
    project.actual_cost = 10
    project.target_cost = 20
    project.save
    proj_in_table = Project.find(1)
    proj_in_table.update_status_cost
    assert(proj_in_table.status_cost == BigDecimal(0.5, 10), "Failed to correctly calculate status_cost, instead of 0.5 got: #{proj_in_table.status_cost}")
  end

  it 'correctly sets status_cost if target_cost == zero' do
    project = generate
    project.target_cost = 0
    project.save
    proj_in_table = Project.find(1)
    proj_in_table.update_status_cost
    assert(proj_in_table.status_cost == BigDecimal(0, 10), "Failed to correctly set status_cost, instead of 0 got: #{proj_in_table.status_cost}")
  end

  ### UPDATE_TARGET_MANP
  it 'correctly calculates its target_manp from its children' do 
    project = gen_with_children
    project.save()
    proj_in_table = Project.find(1)
    proj_in_table.update_target_manp
    assert(proj_in_table.target_manp == 13, "Failed to correctly update target_manp, instead of 13 got: #{proj_in_table.target_manp}")
  end

  it 'correctly calculates its target_manp when it has no children' do
    project = generate
    project.save()
    proj_in_table = Project.find(1)
    proj_in_table.update_target_manp
    assert(proj_in_table.target_manp == 0, "Failed to correctly update target_manp, instead of 0 got: #{proj_in_table.target_manp}")
  end

  ### UPDATE_TARGET_COST
  it 'correctly calculates its target_cost from its children' do
    project = gen_with_children
    project.save()
    proj_in_table = Project.find(1)
    proj_in_table.update_target_cost
    assert(proj_in_table.target_cost == 63.25, "Failed to correctly update target_cost, instead of 63.25 got: #{proj_in_table.target_cost}")
  end

  it 'correctly calculates its target_cost when it has no children' do
    project = generate
    project.save()
    proj_in_table = Project.find(1)
    proj_in_table.update_target_cost
    assert(proj_in_table.target_cost == 0, "Failed to correctly update target_cost, instead of 0 got: #{proj_in_table.target_cost}")
  end

  ### UPDATE_STATUS_MS
  it 'correctly calculates phase progress if there are no children' do
    project = generate
    project.save
    proj_in_table = Project.find(1)
    proj_in_table.update_status_ms
    assert(proj_in_table.status_ms == {-1=>0, 1=>0, 2=>0, 3=>0, 4=>0}, "Failed to correctly set phase progresses,  instead of all 0, got: #{proj_in_table.status_ms}")
  end

  it 'correctly calculates phase progress from multiple children' do
    project = generate
    project.save

    activity1 = gen_activity
    activity1.phase = Activity::CONCEPT_COMPLETED
    activity1.actualProg = Activity::COMPLETED
    activity1.save

    activity2 = gen_activity
    activity2.phase = Activity::PREREQUISITES_FULFILLED
    activity2.actualProg = Activity::COMPLETED
    activity2.save

    activity3 = gen_activity
    activity3.phase = Activity::IMPLEMENTATION_RUNNING
    activity3.actualProg = Activity::IN_PROGRESS
    activity3.save

    activity4 = gen_activity
    activity4.phase = Activity::PROJECT_EFFECTIVE
    activity4.actualProg = Activity::NOT_YET_STARTED
    activity4.save

    proj_in_table = Project.find(1)
    proj_in_table.update_status_ms
    assert(proj_in_table.status_ms == {-1=>0, 1=>2, 2=>2, 3=>1, 4=>0}, "Failed to correctly set phase actualProgress, got: #{proj_in_table.status_ms}")
  end

  it 'correctly calculates Completed and not started phase progress from multiple children with the same status' do
    project = generate
    project.save

    activity1 = gen_activity
    activity1.phase = Activity::CONCEPT_COMPLETED
    activity1.actualProg = Activity::COMPLETED
    activity1.save

    activity2 = gen_activity
    activity2.phase = Activity::CONCEPT_COMPLETED
    activity2.actualProg = Activity::COMPLETED
    activity2.save

    activity3 = gen_activity
    activity3.phase = Activity::PREREQUISITES_FULFILLED
    activity3.actualProg = Activity::NOT_YET_STARTED
    activity3.save

    activity4 = gen_activity
    activity4.phase = Activity::PREREQUISITES_FULFILLED
    activity4.actualProg = Activity::NOT_YET_STARTED
    activity4.save

    proj_in_table = Project.find(1)
    proj_in_table.update_status_ms
    assert(proj_in_table.status_ms == {-1=>0, 1=>2, 2=>0, 3=>0, 4=>0}, "Failed to correctly set phase actualProgresses, got: #{proj_in_table.status_ms}")
  end

  it 'correctly calculates In Progress phase progress from multiple children with the completed and not_yet_started progresses' do
    project = generate
    project.save

    activity1 = gen_activity
    activity1.phase = Activity::CONCEPT_COMPLETED
    activity1.actualProg = Activity::COMPLETED
    activity1.save

    activity2 = gen_activity
    activity2.phase = Activity::CONCEPT_COMPLETED
    activity2.actualProg = Activity::COMPLETED
    activity2.save

    activity3 = gen_activity
    activity3.phase = Activity::CONCEPT_COMPLETED
    activity3.actualProg = Activity::COMPLETED
    activity3.save

    activity4 = gen_activity
    activity4.phase = Activity::CONCEPT_COMPLETED
    activity4.actualProg = Activity::NOT_YET_STARTED
    activity4.save

    proj_in_table = Project.find(1)
    proj_in_table.update_status_ms
    assert(proj_in_table.status_ms == {-1=>0, 1=>1, 2=>0, 3=>0, 4=>0}, "Failed to correctly set phase actualProgresses, got: #{proj_in_table.status_ms}")
  end

  ### EXTRA

  ## Running Rspec remotely (RoR)
  ## Credit: Yong Hoon Lee
  ## Source: https://sites.google.com/a/eecs.berkeley.edu/cs169-sp13/project/setting-up-a-deployment-site
  after(:each) do
    Project.delete_all
    Activity.delete_all
  end
end
