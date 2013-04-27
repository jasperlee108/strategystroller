require 'spec_helper'

describe Goal do

  ### NOTE: Using ruby format, not Rspec
  
  def generate
    goal = Goal.new(
    :name => "Name of Goal",
    :need => "Call for action",
    :justification => "Justification of specific goal",
    :focus => "Strategic approach",
    :notes => "Notes",
    :status => 0.01,
    :dimension_id => 1,
    :user_id => 1,
    :prereq => "A Different Goal's Name",
    :short_name => "Shorter name"
    )
    return goal
  end

  def gen_with_children
    goal = generate()
    indicator1 = Indicator.new(
        :name => "Name der Messgrobe",
        :description => "Beschreibung der Messgrobe",
        :source => "Quelle",
        :unit => "Einheit",
        :freq => [3,6,9,12],
        :year => 2013,
        :reported_values => [0.2, 0.65],
        :indicator_type => "average",
        :prognosis => 0.6543,
        :dir => "more is better",
        :actual => 0.055,
        :target => 0.105,
        :notes => "Anmerkungen",
        :diff => 5.0,
        :status => 0.755,
        :contributing_projects_status => 0.693,
        :status_notes => "Anmerkungen zum Status",
        :goal_id => 1,
        :user_id => 1,
        :short_name => "Shorter name"
    )
    indicator2 = Indicator.new(  # Not a child of this goal.
        :name => "Name der Messgrobe2",
        :description => "Beschreibung der Messgrobe2",
        :source => "Quelle2",
        :unit => "Einheit2",
        :freq => [3,6,9,12],
        :year => 2013,
        :reported_values => [0.2, 0.65],
        :indicator_type => "average",
        :prognosis => 0.6543,
        :dir => "more is better",
        :actual => 0.055,
        :target => 0.105,
        :notes => "Anmerkungen2",
        :diff => 0.050,
        :status => 0.111,
        :contributing_projects_status => 0.201,
        :status_notes => "Anmerkungen zum Status2",
        :goal_id => 3,
        :user_id => 1,
        :short_name => "Shorter name"
    )
    indicator1.save()
    indicator2.save()
    return goal
  end

  ## Default
  it "should pass assert true sanity test" do
    assert(true, "Did not pass sanity check")
  end

  ## All Correct
  it "should behave correctly on good inputs" do
    goal = generate()
    assert(goal.save, "It won't save on good inputs")
  end

  ### NAME
  
  ## Name is not empty
  it "should not have empty Name" do
    name = ""
    goal = generate()
    goal.name = name
    assert(!goal.save, "It saves on empty Name")
  end
  
  ## Name max = 80
  it "should not have Name longer than 80 characters" do
    name = (0...81).map{ ( 65+rand(26) ).chr }.join
    goal = generate()
    goal.name = name
    assert(!goal.save, "It saves on Name longer than 80 characters")
  end
  
  ### NEED
  
  ## Need can be empty
  it "should be allowed to have empty Need" do
    need = ""
    goal = generate()
    goal.need = need
    assert(goal.save, "It won't save on empty Need")
  end
  
  ## Need max = 1200
  it "should not have Need longer than 1200 characters" do
    need = (0...1201).map{ ( 65+rand(26) ).chr }.join
    goal = generate()
    goal.need = need
    assert(!goal.save, "It saves on Need longer than 1200 characters")
  end
  
  ### JUSTIFICATION
  
  ## Justification can be empty
  it "should be allowed to have empty Justification" do
    justification = ""
    goal = generate()
    goal.justification = justification
    assert(goal.save, "It won't save on empty Justification")
  end
  
  ## Justification max = 1200
  it "should not have Justification longer than 1200 characters" do
    justification = (0...1201).map{ ( 65+rand(26) ).chr }.join
    goal = generate()
    goal.justification = justification
    assert(!goal.save, "It saves on Justification longer than 1200 characters")
  end
  
  ### FOCUS
  
  ## Focus can be empty
  it "should be allowed to have empty Focus" do
    focus = ""
    goal = generate()
    goal.focus = focus
    assert(goal.save, "It won't save on empty Focus")
  end
  
  ## Focus max = 1200
  it "should not have Focus longer than 1200 characters" do
    focus = (0...1201).map{ ( 65+rand(26) ).chr }.join
    goal = generate()
    goal.focus = focus
    assert(!goal.save, "It saves on Focus longer than 1200 characters")
  end  

  ### NOTES
  
  ## Notes can be empty
  it "should be allowed to have empty Notes" do
    notes = ""
    goal = generate()
    goal.notes = notes
    assert(goal.save, "It won't save on empty Notes")
  end
  
  ## Notes max = 600
  it "should not have Notes longer than 600 characters" do
    notes = (0...601).map{ ( 65+rand(26) ).chr }.join
    goal = generate()
    goal.notes = notes
    assert(!goal.save, "It saves on Notes longer than 600 characters")
  end  
  
  ### STATUS
  
  ## Status is not empty
  it "should not have empty Status" do
    status = nil
    goal = generate()
    goal.status = status
    assert(!goal.save, "It saves on empty Status")
  end
  
  ## Status >= 0
  it "should have Status of at least 0" do
    status = -1.50
    goal = generate()
    goal.status = status
    assert(!goal.save, "It saves on Status less than 0")
  end
  
  ### PREREQUISITE

  ## Prereq can be empty
  it "should be allowed to have empty Prereq" do
    prereq = ""
    goal = generate()
    goal.prereq = prereq
    assert(goal.save, "It won't save on empty Prereq")
  end
  
  ## Prereq max = 80
  it "should not have Prereq longer than 80 characters" do
    prereq = (0...81).map{ ( 65+rand(26) ).chr }.join
    goal = generate()
    goal.prereq = prereq
    assert(!goal.save, "It saves on Prereq longer than 80 characters")
  end

  ### SHORT NAME

  ## Short Name is not empty
  it "should not have empty Short Name" do
    short_name = ""
    goal = generate()
    goal.short_name = short_name
    assert(!goal.save, "It saves on empty Short Name")
  end

  ## Short Name max = 30
  it "should not have Short Name longer than 30 characters" do
    short_name = (0...31).map{ ( 65+rand(26) ).chr }.join
    goal = generate()
    goal.short_name = short_name
    assert(!goal.save, "It saves on Short Name longer than 30 characters")
  end

  ### Status Update/calculation
  it 'can find the correct number of children' do
    goal = gen_with_children()
    goal.save()
    goal_in_table = Goal.find(1)
    assert(goal_in_table.indicators.count == 1, "goal counted #{goal_in_table.indicators.count} children, not 1 as expected")
  end

  it 'can update its status using its children' do
    goal = gen_with_children()
    goal.save()
    goal_in_table = Goal.find(1)
    goal_in_table.update_status()
    assert(goal_in_table.status == 0.693, "goal status value was #{goal_in_table.status}, not 0.693 as expected")
  end

  it 'can update itself even if it has no children' do
    goal = generate()
    goal.save()
    goal_in_table = Goal.find(1)
    goal_in_table.update_status()
    assert(goal_in_table.status == 0.0, "goal status value was #{goal_in_table.status}, not 0.0 as expected")
  end

  ### EXTRA
  
  ## Running Rspec remotely (RoR)
  ## Credit: Yong Hoon Lee
  ## Source: https://sites.google.com/a/eecs.berkeley.edu/cs169-sp13/project/setting-up-a-deployment-site
  after(:each) do
    Goal.delete_all
    Indicator.delete_all
  end
end
