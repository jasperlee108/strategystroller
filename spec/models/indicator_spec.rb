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
    :prognosis => 0.6543,
    :dir => "more is better",
    :actual => 0.55,
    :target => 0.105,
    :notes => "Anmerkungen",
    :diff => 0.05,
    :status => 0.755,
    :contributing_projects_status => 0.693,
    :status_notes => "Anmerkungen zum Status",
    :goal_id => 1,
    :user_id => 1,
    :short_name => "Shorter name"
    )
    return indicator
  end

  def gen_with_children
    indicator = generate
    project1 = Project.new(
        :name => "Projekts",
        :description => "Projektbeschreibung",
        :startDate => Date.new(2013,03,27),
        :endDate => Date.new(2013,03,28),
        :actual_duration => 15,
        :target_duration => 52,
        :target_manp => 5,
        :target_cost => 10.5,
        :inplan => true,
        :compensation => true,
        :notes => "Anmerkungen",
        :actual_manp => 10,
        :actual_cost => 0.205,
        :status_prog => 0.755,
        :status_ms => {-1=>0, 1=>0, 2=>0, 3=>0, 4=>0},
        :status_manp => 10,
        :status_cost => 10.5,
        :status_global => 0.505,
        :status_notes => "Anmerkungen zum Status",
        :indicator_id => 1,
        :head_id => 1,
        :steer_id => 1,
        :team => "James Bond, Andy Warhol",
        :yearly_target_manp => { 2013 => BigDecimal(5.5,6)},
        :yearly_target_cost => { 2013 => BigDecimal(25.25,6)},
        :short_name => "Shorter name"
    )
    project2 = Project.new(  # Not a child of this indicator.
        :name => "Projekts2",
        :description => "Projektbeschreibung2",
        :startDate => Date.new(2013,03,27),
        :endDate => Date.new(2013,03,28),
        :actual_duration => 15,
        :target_duration => 52,
        :target_manp => 5,
        :target_cost => 10.5,
        :inplan => true,
        :compensation => true,
        :notes => "Anmerkungen2",
        :actual_manp => 10,
        :actual_cost => 20.5,
        :status_prog => 75.5,
        :status_ms => {-1=>0, 1=>0, 2=>0, 3=>0, 4=>0},
        :status_manp => 10,
        :status_cost => 10.5,
        :status_global => 50.5,
        :status_notes => "Anmerkungen zum Status2",
        :indicator_id => 3,
        :head_id => 1,
        :steer_id => 1,
        :team => "James Bond2, Andy Warhol2",
        :yearly_target_manp => {2013 => BigDecimal(5.5,6)},
        :yearly_target_cost => {2013 => BigDecimal(25.25,6)},
        :short_name => "Shorter name"
    )
    project1.save
    project2.save
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
  
  ## Source is not empty
  it "should allow empty Source" do
    source = ""
    indicator = generate()
    indicator.source = source
    assert(indicator.save, "It saves on empty Source")
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

  it "will not save :reported_values with non-decimal elements" do
    reported_values = [0.2, 2]
    indicator = generate()
    indicator.reported_values = reported_values
    assert(!indicator.save, "It saves a reported_values with a non-decimal element")
  end

  it "will not save :reported_values with negative elements" do
    reported_values = [0.2, -0.1]
    indicator = generate()
    indicator.reported_values = reported_values
    assert(!indicator.save, "It saves a reported_values with a negative element")
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

  it "will save :reported_values with an empty array" do
    reported_values = []
    indicator = generate()
    indicator.reported_values = reported_values
    assert(indicator.save, "It will not save a :reported_values with an empty Array")
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
  
  ## Direction max = 20 = { 'More is Better', 'Less is Better' }
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
  
  ## Actual = decimal
  it "should have Actual as a decimal" do
    actual = "random"
    indicator = generate()
    indicator.actual = actual
    assert(!indicator.save, "It saves on Actual = " + actual.to_s)
  end

  ## Actual = decimal >= 0
  it "should have Actual as a decimal >= 0" do
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
  
  ## Target = decimal
  it "should have Target as a decimal" do
    target = "random"
    indicator = generate()
    indicator.target = target
    assert(!indicator.save, "It saves on Target = " + target.to_s)
  end

  ## Target = decimal > 0
  it "should have Target as a decimal > 0" do
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
  
  ## Difference = decimal
  it "should have Difference as a decimal" do
    difference = "random"
    indicator = generate()
    indicator.diff = difference
    assert(!indicator.save, "It saves on Difference = " + difference.to_s)
  end

  ## Difference = decimal
  it "should have Difference as a decimal, negatives are ok" do
    difference = -5
    indicator = generate()
    indicator.diff = difference
    assert(indicator.save, "It won't save on Difference = " + difference.to_s)
  end

  ### STATUS
  
  ## Status is not empty
  it "should not have empty Status" do
    status = nil
    indicator = generate()
    indicator.status = status
    assert(!indicator.save, "It saves on empty Status")
  end
  
  ## Status = decimal
  it "should have Status as a decimal" do
    status = "random"
    indicator = generate()
    indicator.status = status
    assert(!indicator.save, "It saves on Status = " + status.to_s)
  end

  ## Status = decimal >= 0
  it "should have Status as a decimal >= 0" do
    status = -5
    indicator = generate()
    indicator.status = status
    assert(!indicator.save, "It saves on Status = " + status.to_s)
  end

  ### CONTRIBUTING_PROJECTS_STATUS

  ## contributing_projects_status is not empty
  it "should not have empty contributing_projects_status" do
    contributing_projects_status = nil
    indicator = generate()
    indicator.contributing_projects_status = contributing_projects_status
    assert(!indicator.save, "It saves on empty contributing_projects_status")
  end

  ## contributing_projects_status = decimal
  it "should have contributing_projects_status as a decimal" do
    contributing_projects_status = "random"
    indicator = generate()
    indicator.contributing_projects_status = contributing_projects_status
    assert(!indicator.save, "It saves on contributing_projects_status = " + contributing_projects_status.to_s)
  end

  ## contributing_projects_status = decimal >= 0
  it "should have contributing_projects_status as a decimal >= 0" do
    contributing_projects_status = -5
    indicator = generate()
    indicator.contributing_projects_status = contributing_projects_status
    assert(!indicator.save, "It saves on contributing_projects_status = " + contributing_projects_status.to_s)
  end

  ### PROGNOSIS

  ## prognosis is not empty
  it "should not have empty prognosis" do
    prognosis = nil
    indicator = generate()
    indicator.prognosis = prognosis
    assert(!indicator.save, "It saves on empty prognosis")
  end

  ## prognosis = decimal
  it "should have prognosis as a decimal" do
    prognosis = "random"
    indicator = generate()
    indicator.prognosis = prognosis
    assert(!indicator.save, "It saves on prognosis = " + prognosis.to_s)
  end

  ## prognosis = decimal >= 0
  it "should have prognosis as a decimal >= 0" do
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

  ### UPDATE_PROGNOSIS

  ## :reported_values = [] --> :prognosis = 0.0
  it "will give a prognosis of zero if there are no reoported_values" do
    reported_values = []
    indicator = generate
    indicator.reported_values = reported_values
    indicator.save
    indicator_in_table = Indicator.find(1)
    indicator_in_table.update_prognosis
    assert(indicator_in_table.prognosis == 0.0, ":prognosis was #{indicator_in_table.prognosis}, not 0.0 as anticipated")
  end

  # :prognosis w/ indicator type average performs an average
  it "will give a prognosis based on the average values of it is an average type" do
    reported_values = [0.2, 0.4, 0.6]
    indicator = generate
    indicator.reported_values = reported_values
    indicator.indicator_type = "average"
    indicator.save
    indicator_in_table = Indicator.find(1)
    indicator_in_table.update_prognosis
    assert(indicator_in_table.prognosis == 0.4, ":prognosis was #{indicator_in_table.prognosis}, not 0.4 as anticipated")
  end

  # :prognosis w/ indicator type cumulative gives a projected cumulative value
  it "will give a prognosis based on the cumulative values of it is a cumulative type" do
    reported_values = [0.2, 0.4, 0.6]
    indicator = generate
    indicator.reported_values = reported_values
    indicator.indicator_type = "cumulative"
    indicator.save
    indicator_in_table = Indicator.find(1)
    indicator_in_table.update_prognosis
    assert(indicator_in_table.prognosis == BigDecimal.new(1.2,10)*12/Time.now.month, ":prognosis was #{indicator_in_table.prognosis}, not #{BigDecimal.new(1.2,10)*12/Time.now.month} as anticipated")
  end

  ### UPDATE_DIFF

  #it correctly calculates and stores the difference.
  it "will update diff" do
    reported_values = [0.2, 0.4, 0.6]
    indicator = generate
    indicator.reported_values = reported_values
    indicator.indicator_type = "average"
    indicator.target = 0.3
    indicator.save
    indicator_in_table = Indicator.find(1)
    indicator_in_table.update_prognosis
    indicator_in_table.update_diff
    assert(indicator_in_table.diff == 0.1, ":diff was #{indicator_in_table.diff}, not 0.1 as anticipated")
  end

  #it correctly calculates and stores the difference.
  it "will update diff even if it is a negative value" do
    reported_values = [0.2, 0.4, 0.6]
    indicator = generate
    indicator.reported_values = reported_values
    indicator.indicator_type = "average"
    indicator.target = 0.5
    indicator.save
    indicator_in_table = Indicator.find(1)
    indicator_in_table.update_prognosis
    indicator_in_table.update_diff
    assert(indicator_in_table.diff == -0.1, ":diff was #{indicator_in_table.diff}, not -0.1 as anticipated")
  end

  ### update_status
  #TODO confirm if it is possible for this to lead to a negative status (I suspect yes)

  # correctly calculates "more is better" status
  it "will update 'more is better' case correctly" do
    reported_values = [0.2, 0.4, 0.6]
    indicator = generate
    indicator.reported_values = reported_values
    indicator.indicator_type = "average"
    indicator.target = 0.2
    indicator.dir = "more is better"
    indicator.save
    indicator_in_table = Indicator.find(1)
    indicator_in_table.update_prognosis
    indicator_in_table.update_diff
    indicator_in_table.update_status
    assert(indicator_in_table.status == 6.0, ":status was #{indicator_in_table.status}, not 6.0 as anticipated")
  end

  # correctly calculates "less is better" status
  it "will update 'less is better' case correctly" do
    reported_values = [0.2, 0.4, 0.6]
    indicator = generate
    indicator.reported_values = reported_values
    indicator.indicator_type = "average"
    indicator.target = 0.2
    indicator.dir = "less is better"
    indicator.save
    indicator_in_table = Indicator.find(1)
    indicator_in_table.update_prognosis
    indicator_in_table.update_diff
    indicator_in_table.update_status
    assert(indicator_in_table.status == 4.0, ":status was #{indicator_in_table.status}, not 4.0 as anticipated")
  end

  ### UPDATE_CONTRIBUTING_PROJECTS_STATUS

  it 'can find the correct number of children' do
    indicator = gen_with_children()
    indicator.save()
    indicator_in_table = Indicator.find(1)
    assert(indicator_in_table.projects.count == 1, "indicator counted #{indicator_in_table.projects.count} children, not 1 as expected")
  end

  it 'can update its contributing_projects_status using its children' do
    indicator = gen_with_children()
    indicator.save()
    indicator_in_table = Indicator.find(1)
    indicator_in_table.update_contributing_projects_status()
    assert(indicator_in_table.contributing_projects_status == 0.505, "indicator status value was #{indicator_in_table.contributing_projects_status}, not 0.505 as expected")
  end

  it 'can update itself even if it has no children' do
    indicator = generate()
    indicator.save()
    indicator_in_table = Indicator.find(1)
    indicator_in_table.update_contributing_projects_status()
    assert(indicator_in_table.contributing_projects_status == 0.0, "indicator status value was #{indicator_in_table.contributing_projects_status}, not 0.0 as expected")
  end


  ### EXTRA
  
  ## Running Rspec remotely (RoR)
  ## Credit: Yong Hoon Lee
  ## Source: https://sites.google.com/a/eecs.berkeley.edu/cs169-sp13/project/setting-up-a-deployment-site
  after(:each) do
    Indicator.delete_all
  end
end
