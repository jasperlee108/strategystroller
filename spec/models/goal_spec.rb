require 'spec_helper'

describe Goal do

  ### NOTE: Using ruby format, not Rspec
  
  ## Default
  it "should pass assert true sanity test" do
    assert(true, "Did not pass sanity check")
  end

  ### NAME
  
  ## Name is not empty
  it "should not have empty Name" do
    goal = Goal.new(
    :name => "",
    :need => "Call for action",
    :justification => "Justification of specific goal",
    :focus => "Strategic approach",
    :notes => "Notes",
    :status => 0.00
    )
    assert(!goal.save, "Name is empty")
  end
  
  ## Name max = 80
  it "should not have Name longer than 80 characters" do
    goal = Goal.new(
    :name => (0...81).map{ ( 65+rand(26) ).chr }.join,
    :need => "Call for action",
    :justification => "Justification of specific goal",
    :focus => "Strategic approach",
    :notes => "Notes",
    :status => 0.00
    )
    assert(!goal.save, "Name is longer than 80 characters")
  end
  
  ### NEED
  
  ## Need is not empty
  it "should not have empty Need" do
    goal = Goal.new(
    :name => "Name of goal",
    :need => "",
    :justification => "Justification of specific goal",
    :focus => "Strategic approach",
    :notes => "Notes",
    :status => 0.00
    )
    assert(!goal.save, "Need is empty")
  end
  
  ## Need max = 1200
  it "should not have Need longer than 1200 characters" do
    goal = Goal.new(
    :name => "Name of goal",
    :need => (0...1201).map{ ( 65+rand(26) ).chr }.join,
    :justification => "Justification of specific goal",
    :focus => "Strategic approach",
    :notes => "Notes",
    :status => 0.00
    )
    assert(!goal.save, "Need is longer than 1200 characters")
  end
  
  ### JUSTIFICATION
  
  ## Justification is not empty
  it "should not have empty Justification" do
    goal = Goal.new(
    :name => "Name of goal",
    :need => "Call for action",
    :justification => "",
    :focus => "Strategic approach",
    :notes => "Notes",
    :status => 0.00
    )
    assert(!goal.save, "Justification is empty")
  end
  
  ## Need max = 1200
  it "should not have Need longer than 1200 characters" do
    goal = Goal.new(
    :name => "Name of goal",
    :need => "Call for action",
    :justification => (0...1201).map{ ( 65+rand(26) ).chr }.join,
    :focus => "Strategic approach",
    :notes => "Notes",
    :status => 0.00
    )
    assert(!goal.save, "Justification is longer than 1200 characters")
  end
  
  ### FOCUS
  
  ## Focus is not empty
  it "should not have empty Focus" do
    goal = Goal.new(
    :name => "Name of goal",
    :need => "Call for action",
    :justification => "Justification of specific goal",
    :focus => "",
    :notes => "Notes",
    :status => 0.00
    )
    assert(!goal.save, "Focus is empty")
  end
  
  ## Focus max = 1200
  it "should not have Focus longer than 1200 characters" do
    goal = Goal.new(
    :name => "Name of goal",
    :need => "Call for action",
    :justification => "Justification of specific goal",
    :focus => (0...1201).map{ ( 65+rand(26) ).chr }.join,
    :notes => "Notes",
    :status => 0.00
    )
    assert(!goal.save, "Focus is longer than 1200 characters")
  end  

  ### NOTES
  
  ## Notes can be empty
  it "should be allowed to have empty Notes" do
    goal = Goal.new(
    :name => "Name of goal",
    :need => "Call for action",
    :justification => "Justification of specific goal",
    :focus => "Strategic approach",
    :notes => "",
    :status => 0.00
    )
    assert(goal.save, "Notes can be empty")
  end
  
  ## Notes max = 600
  it "should not have Notes longer than 600 characters" do
    goal = Goal.new(
    :name => "Name of goal",
    :need => "Call for action",
    :justification => "Justification of specific goal",
    :focus => "Strategic approach",
    :notes => (0...601).map{ ( 65+rand(26) ).chr }.join,
    :status => 0.00
    )
    assert(!goal.save, "Notes is longer than 600 characters")
  end  
  
  ### STATUS
  
  ## Status >= 0
  it "should have Status of at least 0" do
    goal = Goal.new(
    :name => "Name of goal",
    :need => "Call for action",
    :justification => "Justification of specific goal",
    :focus => "Strategic approach",
    :notes => "Notes",
    :status => -1.50
    )
    assert(!goal.save, "Status is less than 0")
  end
  
  ## Status <= 100
  it "should have Status of at most 100" do
    goal = Goal.new(
    :name => "Name of goal",
    :need => "Call for action",
    :justification => "Justification of specific goal",
    :focus => "Strategic approach",
    :notes => "Notes",
    :status => 100.50
    )
    assert(!goal.save, "Status is more than 100")    
  end

  ### EXTRA
  
  ## Running Rspec remotely (RoR)
  ## Credit: Yong Hoon Lee
  ## Source: https://sites.google.com/a/eecs.berkeley.edu/cs169-sp13/project/setting-up-a-deployment-site
  after(:each) do
    Goal.delete_all
  end
end
