require 'spec_helper'

describe Indicator do

  ### NOTE: Using ruby format, not Rspec
  
  def generate
    indicator = Indicator.new(
    :name => "Name der Messgrobe",
    :description => "Beschreibung der Messgrobe",
    :source => "Quelle",
    :unit => "Einheit",
    :freq => [3,6,9,12],
    :year => 2013,
    :reported_values => [0.2, 0.65],
    :indicator_type => "average",
    :prognosis => 65.43,
    :dir => "more is better",
    :actual => 5.5,
    :target => 10.5,
    :notes => "Anmerkungen",
    :diff => 5.0,
    :status => 75.5,
    :contributing_projects_status => 69.3,
    :status_notes => "Anmerkungen zum Status",
    :goal_id => 1,
    :user_id => 1
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
  
  ## Source is not empty
  it "should not have empty Source" do
    source = ""
    indicator = generate()
    indicator.source = source
    assert(!indicator.save, "It saves on empty Source")
  end
  
  ## Source max = 200
  it "should not have Source longer than 200 characters" do
    source = (0...201).map{ ( 65+rand(26) ).chr }.join
    indicator = generate()
    indicator.source = source
    assert(!indicator.save, "It saves on Source longer than 200 characters")
  end

  ### UNIT
  
  ## Unit is not empty
  it "should not have empty Unit" do
    unit = ""
    indicator = generate()
    indicator.unit = unit
    assert(!indicator.save, "It saves on empty Unit")
  end
  
  ## Unit max = 20
  it "should not have Unit longer than 20 characters" do
    unit = (0...21).map{ ( 65+rand(26) ).chr }.join
    indicator = generate()
    indicator.unit = unit
    assert(!indicator.save, "It saves on Unit longer than 20 characters")
  end

  ### FREQUENCY

  ## Frequency is not empty
  it "should not have empty Frequency" do
    freq = []
    indicator = generate()
    indicator.freq = freq
    assert(!indicator.save, "It saves on empty Frequency")
  end

  it "will not save a non-array Frequency" do
    freq = "lolhi"
    indicator = generate()
    indicator.freq = freq
    assert(!indicator.save, "It saves a non-array Frequency")
  end
  
  ## Frequency max = 12 months
  it "should not have Frequency with more than 12 elements" do
    freq = [1,2,3,4,5,6,7,8,9,10,11,12,13]
    indicator = generate()
    indicator.freq = freq
    assert(!indicator.save, "It saves on Frequency longer than 12 elements")
  end

  ## Frequency only allowed values >=1 <= 12
  it "will not save Frequency element with value greater than 12" do
    freq = [1,2,3,13]
    indicator = generate()
    indicator.freq = freq
    assert(!indicator.save, "It saves on Frequency with an element greater than 12")
  end

  ## Frequency only allowed integer elements
  it "will not save Frequency with a non-integer element" do
    freq = [1,2,3,4.5]
    indicator = generate()
    indicator.freq = freq
    assert(!indicator.save, "It saves on Frequency with a non-integer element")
  end

  ### YEAR
  it "will not save an empty year" do
    year = nil
    indicator = generate()
    indicator.year = year
    assert(!indicator.save, "It saves with an empty year")
  end

  it "will not save a non-integer year" do
    year = 20.32
    indicator = generate()
    indicator.year = year
    assert(!indicator.save, "It saves with a non-integer year")
  end

  ### REPORTED_VALUES

  it "will not save a non-array reported_values" do
    reported_values = "lolhi"
    indicator = generate()
    indicator.reported_values = reported_values
    assert(!indicator.save, "It saves a non-array reported_values")
  end

  it "will not save :reported_values with element values < 0" do
    reported_values = [0.2, -0.1]
    indicator = generate()
    indicator.reported_values = reported_values
    assert(!indicator.save, "It saves a non-array reported_values")
  end

  it "will not save :reported_values with non-float elements" do
    reported_values = [0.2, 2]
    indicator = generate()
    indicator.reported_values = reported_values
    assert(!indicator.save, "It saves a reported_values with a non-float element")
  end

  it "will not save :reported_values with negative elements" do
    reported_values = [0.2, -0.1]
    indicator = generate()
    indicator.reported_values = reported_values
    assert(!indicator.save, "It saves a reported_values with a non-float element")
  end

  it "will save :reported_values with a zero element" do
    reported_values = [0.2, 0.0]
    indicator = generate()
    indicator.reported_values = reported_values
    assert(indicator.save, "It won't save a reported_values with a 0.0 element")
  end

  it "will not save :reported_values with more elements than the corresponding frequency" do
    reported_values = [0.1, 0.2, 0.3, 0.4, 0.5]
    indicator = generate()
    indicator.reported_values = reported_values
    assert(!indicator.save, "It saved a :reported_values with a more elements than the corresponding :freq")
  end

  ### TYPE
  
  ## Type is not empty
  it "should not have empty Type" do
    type = ""
    indicator = generate()
    indicator.indicator_type = type
    assert(!indicator.save, "It saves on empty Type")
  end
  
  ## Type max = 10 = { 'average', 'cumulative' }
  it "should not have Type longer than 10 characters" do
    type = (0...11).map{ ( 65+rand(26) ).chr }.join
    indicator = generate()
    indicator.indicator_type = type
    assert(!indicator.save, "It saves on Type longer than 10 characters")
  end

  ### DIRECTION
  
  ## Direction is not empty
  it "should not have empty Direction" do
    direction = ""
    indicator = generate()
    indicator.dir = direction
    assert(!indicator.save, "It saves on empty Direction")
  end
  
  ## Direction max = 20 = { 'more is better', 'less is better' }
  it "should not have Direction longer than 20 characters" do
    direction = (0...21).map{ ( 65+rand(26) ).chr }.join
    indicator = generate()
    indicator.dir = direction
    assert(!indicator.save, "It saves on Direction longer than 20 characters")
  end

  ### ACTUAL VALUES

  ## Actual is not empty
  it "should not have empty Actual" do
    actual = nil
    indicator = generate()
    indicator.actual = actual
    assert(!indicator.save, "It saves on empty Actual")
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
  
  ## Target is not empty
  it "should not have empty Target" do
    target = nil
    indicator = generate()
    indicator.target = target
    assert(!indicator.save, "It saves on empty Target")
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
  
  ## Difference is not empty
  it "should not have empty Difference" do
    difference = nil
    indicator = generate()
    indicator.diff = difference
    assert(!indicator.save, "It saves on empty Difference")
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
  
  ## Status is not empty
  it "should not have empty Status" do
    status = nil
    indicator = generate()
    indicator.status = status
    assert(!indicator.save, "It saves on empty Status")
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

  ### contributing_projects_status

  ## contributing_projects_status is not empty
  it "should not have empty contributing_projects_status" do
    contributing_projects_status = nil
    indicator = generate()
    indicator.contributing_projects_status = contributing_projects_status
    assert(!indicator.save, "It saves on empty contributing_projects_status")
  end

  ## contributing_projects_status = float
  it "should have contributing_projects_status as a float" do
    contributing_projects_status = "random"
    indicator = generate()
    indicator.contributing_projects_status = contributing_projects_status
    assert(!indicator.save, "It saves on contributing_projects_status = " + contributing_projects_status.to_s)
  end

  ## contributing_projects_status = float >= 0
  it "should have contributing_projects_status as a float >= 0" do
    contributing_projects_status = -5
    indicator = generate()
    indicator.contributing_projects_status = contributing_projects_status
    assert(!indicator.save, "It saves on contributing_projects_status = " + contributing_projects_status.to_s)
  end

  ### prognosis

  ## prognosis is not empty
  it "should not have empty prognosis" do
    prognosis = nil
    indicator = generate()
    indicator.prognosis = prognosis
    assert(!indicator.save, "It saves on empty prognosis")
  end

  ## prognosis = float
  it "should have prognosis as a float" do
    prognosis = "random"
    indicator = generate()
    indicator.prognosis = prognosis
    assert(!indicator.save, "It saves on prognosis = " + prognosis.to_s)
  end

  ## prognosis = float >= 0
  it "should have prognosis as a float >= 0" do
    prognosis = -5
    indicator = generate()
    indicator.prognosis = prognosis
    assert(!indicator.save, "It saves on prognosis = " + prognosis.to_s)
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

  ### EXTRA
  
  ## Running Rspec remotely (RoR)
  ## Credit: Yong Hoon Lee
  ## Source: https://sites.google.com/a/eecs.berkeley.edu/cs169-sp13/project/setting-up-a-deployment-site
  after(:each) do
    Indicator.delete_all
  end
end
