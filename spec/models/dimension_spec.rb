require 'spec_helper'

describe Dimension do
  
  ### NOTE: Using ruby format, not Rspec
  
  def generate
    dimension = build(:dimension) # TODO refactor method out
    return dimension
  end

  def gen_with_children
    dimension = generate()
    goal1 = build(:goal, status: 0.23)
    goal2 = build(:goal, status: 0.43, dimension_id: 3) #a different dimension's goal
    goal3 = build(:goal, status: 0.69)
    goal1.save()
    goal2.save()
    goal3.save()
    return dimension
  end

  
  ## Default
  it "should pass assert true sanity test" do
    assert(true, "Did not pass sanity check")
  end

  ## All Correct
  it "should behave correctly on good inputs" do
    dimension = generate()
    assert(dimension.save, "It won't save on good inputs")
  end

  ### NAME
  
  ## Name is not empty
  it "should not have empty Name" do
    name = ""
    dimension = generate()
    dimension.name = name
    assert(!dimension.save, "It saves on empty Name")
  end
  
  ## Name max = 80
  it "should not have Name longer than 30 characters" do
    name = (0...31).map{ ( 65+rand(26) ).chr }.join
    dimension = generate()
    dimension.name = name
    assert(!dimension.save, "It saves on Name longer than 30 characters")
  end

  ### STATUS
  
  ## Status is not empty
  it "should not have empty Status" do
    status = ""
    dimension = generate()
    dimension.status = status
    assert(!dimension.save, "It saves on empty Status")
  end
  
  ## Status >= 0
  it "should have Status of at least 0" do
    status = -1.50
    dimension = generate()
    dimension.status = status
    assert(!dimension.save, "It saves on Status less than 0")
  end
  
  ### Status Update/calculation

  it 'can update its status using its children' do
    dimension = gen_with_children()
    dimension.save()
    dimension_in_table = Dimension.find(1)
    dimension_in_table.update_status()
    assert(dimension_in_table.status == 0.46, "dimension status value was #{dimension_in_table.status}, not 0.46 as expected")
  end

  it 'can update its even if it has no children' do
    dimension = generate()
    dimension.save()
    dimension_in_table = Dimension.find(1)
    dimension_in_table.update_status()
    assert(dimension_in_table.status == 0.0, "dimension status value was #{dimension_in_table.status}, not 0.0 as expected")
  end

  ### EXTRA
  
  ## Running Rspec remotely (RoR)
  ## Credit: Yong Hoon Lee
  ## Source: https://sites.google.com/a/eecs.berkeley.edu/cs169-sp13/project/setting-up-a-deployment-site
  after(:each) do
    Dimension.delete_all
    Goal.delete_all
  end
end
