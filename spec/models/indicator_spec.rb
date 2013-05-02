require 'spec_helper'

describe Indicator do

  ### NOTE: Using ruby format, not Rspec
  
  def generate
    indicator = Indicator.new(
    :name => "Name der Messgrobe",
    :description => "Beschreibung der Messgrobe",
    :source => "Quelle",
    :unit => "Einheit",
    :freq => [1,2,3],
    :indicator_type => "average",
    :dir => "more is better",
    :actual => 5.5,
    :target => 10.5,
    :notes => "Anmerkungen",
    :diff => 5.0,
    :status => 75.5,
    :status_notes => "Anmerkungen zum Status",
    :goal_id => 1,
    :user_id => 1,
    :short_name => "Shorter name"
    )
    return indicator
  end

  ## Default
  it "should pass assert true sanity test" do
    assert(true, "Did not pass sanity check")
  end

  ## All Correct
  it "should behave correctly on good inputs" do
    indicator = generate()
    assert(indicator.save, "It won't save on good inputs")
  end

  ### NAME
  
  ## Name is not empty
  it "should not have empty Name" do
    name = ""
    indicator = generate()
    indicator.name = name
    assert(!indicator.save, "It saves on empty Name")
  end
  
  ## Name max = 80
  it "should not have Name longer than 80 characters" do
    name = (0...81).map{ ( 65+rand(26) ).chr }.join
    indicator = generate()
    indicator.name = name
    assert(!indicator.save, "It saves on Name longer than 80 characters")
  end

  ### DESCRIPTION
  
  ## Description can be empty
  it "can have empty Description" do
    description = ""
    indicator = generate()
    indicator.description = description
    assert(indicator.save, "It won't save on empty Description")
  end
  
  ## Description max = 600
  it "should not have Description longer than 600 characters" do
    description = (0...601).map{ ( 65+rand(26) ).chr }.join
    indicator = generate()
    indicator.description = description
    assert(!indicator.save, "It saves on Description longer than 600 characters")
  end

  ### SOURCE
  
  ## Source can be empty
  it "can have empty Source" do
    source = ""
    indicator = generate()
    indicator.source = source
    assert(indicator.save, "It won't save on empty Source")
  end
  
  ## Source max = 200
  it "should not have Source longer than 200 characters" do
    source = (0...201).map{ ( 65+rand(26) ).chr }.join
    indicator = generate()
    indicator.source = source
    assert(!indicator.save, "It saves on Source longer than 200 characters")
  end

  ### UNIT
  
  ## Unit can be empty
  it "can have empty Unit" do
    unit = ""
    indicator = generate()
    indicator.unit = unit
    assert(indicator.save, "It won't save on empty Unit")
  end
  
  ## Unit max = 20
  it "should not have Unit longer than 20 characters" do
    unit = (0...21).map{ ( 65+rand(26) ).chr }.join
    indicator = generate()
    indicator.unit = unit
    assert(!indicator.save, "It saves on Unit longer than 20 characters")
  end

  ### FREQUENCY

  ## Frequency can be empty
  it "can have empty Frequency" do
    freq = []
    indicator = generate()
    indicator.freq = freq
    assert(indicator.save, "It won't save on empty Frequency")
  end

  ### TYPE
  
  ## Type can be empty
  it "can have empty Type" do
    type = ""
    indicator = generate()
    indicator.indicator_type = type
    assert(indicator.save, "It won't save on empty Type")
  end
  
  ## Type max = 10 = { 'average', 'cumulative' }
  it "should not have Type longer than 10 characters" do
    type = (0...11).map{ ( 65+rand(26) ).chr }.join
    indicator = generate()
    indicator.indicator_type = type
    assert(!indicator.save, "It saves on Type longer than 10 characters")
  end

  ### DIRECTION
  
  ## Direction can be empty
  it "can have empty Direction" do
    direction = ""
    indicator = generate()
    indicator.dir = direction
    assert(indicator.save, "It won't save on empty Direction")
  end
  
  ## Direction max = 20 = { 'more is better', 'less is better' }
  it "should not have Direction longer than 20 characters" do
    direction = (0...21).map{ ( 65+rand(26) ).chr }.join
    indicator = generate()
    indicator.dir = direction
    assert(!indicator.save, "It saves on Direction longer than 20 characters")
  end

  ### ACTUAL VALUES

  ## Actual can be empty
  it "can have empty Actual" do
    actual = nil
    indicator = generate()
    indicator.actual = actual
    assert(indicator.save, "It won't save on empty Actual")
  end
  
  ## Actual = float
  it "should have Actual as a float" do
    actual = "random"
    indicator = generate()
    indicator.actual = actual
    assert(!indicator.save, "It saves on Actual = " + actual.to_s)
  end

  ## Actual = float >= 0
  it "should have Actual as a float >= 0" do
    actual = -5
    indicator = generate()
    indicator.actual = actual
    assert(!indicator.save, "It saves on Actual = " + actual.to_s)
  end

  ### TARGET VALUES
  
  ## Target can be empty
  it "can have empty Target" do
    target = nil
    indicator = generate()
    indicator.target = target
    assert(indicator.save, "It won't save on empty Target")
  end
  
  ## Target = float
  it "should have Target as a float" do
    target = "random"
    indicator = generate()
    indicator.target = target
    assert(!indicator.save, "It saves on Target = " + target.to_s)
  end

  ## Target = float >= 0
  it "should have Target as a float >= 0" do
    target = -5
    indicator = generate()
    indicator.target = target
    assert(!indicator.save, "It saves on Target = " + target.to_s)
  end

  ### NOTES
  
  ## Notes can be empty
  it "can have empty Notes" do
    notes = ""
    indicator = generate()
    indicator.notes = notes
    assert(indicator.save, "It won't save on empty Notes")
  end
  
  ## Notes max = 600
  it "should not have Notes longer than 600 characters" do
    notes = (0...601).map{ ( 65+rand(26) ).chr }.join
    indicator = generate()
    indicator.notes = notes
    assert(!indicator.save, "It saves on Notes longer than 600 characters")
  end

  ### DIFFERENCE
  
  ## Difference can be empty
  it "can have empty Difference" do
    difference = nil
    indicator = generate()
    indicator.diff = difference
    assert(indicator.save, "It won't save on empty Difference")
  end
  
  ## Difference = float
  it "should have Difference as a float" do
    difference = "random"
    indicator = generate()
    indicator.diff = difference
    assert(!indicator.save, "It saves on Difference = " + difference.to_s)
  end

  ## Difference = float >= 0
  it "should have Difference as a float >= 0" do
    difference = -5
    indicator = generate()
    indicator.diff = difference
    assert(!indicator.save, "It saves on Difference = " + difference.to_s)
  end

  ### STATUS
  
  ## Status can be empty
  it "can have empty Status" do
    status = nil
    indicator = generate()
    indicator.status = status
    assert(indicator.save, "It won't save on empty Status")
  end
  
  ## Status = float
  it "should have Status as a float" do
    status = "random"
    indicator = generate()
    indicator.status = status
    assert(!indicator.save, "It saves on Status = " + status.to_s)
  end

  ## Status = float >= 0
  it "should have Status as a float >= 0" do
    status = -5
    indicator = generate()
    indicator.status = status
    assert(!indicator.save, "It saves on Status = " + status.to_s)
  end

  ## Status = float <= 100
  it "should have Status as a float <= 100" do
    status = 100.50
    indicator = generate()
    indicator.status = status
    assert(!indicator.save, "It saves on Status = " + status.to_s)
  end

  ### STATUS NOTES
  
  ## Status Notes can be empty
  it "can have empty Status Notes" do
    statusNotes = ""
    indicator = generate()
    indicator.status_notes = statusNotes
    assert(indicator.save, "It won't save on empty Status Notes")
  end
  
  ## Status Notes max = 600
  it "should not have Status Notes longer than 600 characters" do
    statusNotes = (0...601).map{ ( 65+rand(26) ).chr }.join
    indicator = generate()
    indicator.status_notes = statusNotes
    assert(!indicator.save, "It saves on Status Notes longer than 600 characters")
  end

  ### SHORT NAME
  
  ## Short Name is not empty
  it "should not have empty Short Name" do
    short_name = ""
    indicator = generate()
    indicator.short_name = short_name
    assert(!indicator.save, "It saves on empty Short Name")
  end
  
  ## Short Name max = 30
  it "should not have Short Name longer than 30 characters" do
    short_name = (0...31).map{ ( 65+rand(26) ).chr }.join
    indicator = generate()
    indicator.short_name = short_name
    assert(!indicator.save, "It saves on Short Name longer than 30 characters")
  end

  ### EXTRA
  
  ## Running Rspec remotely (RoR)
  ## Credit: Yong Hoon Lee
  ## Source: https://sites.google.com/a/eecs.berkeley.edu/cs169-sp13/project/setting-up-a-deployment-site
  after(:each) do
    Indicator.delete_all
  end
end
