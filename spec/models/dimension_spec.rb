require 'spec_helper'

describe Dimension do
  
  ### NOTE: Using ruby format, not Rspec
  
  def generate
    dimension = Dimension.new(
    :name => "Dimension",
    :status => 75.50
    )
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
  
  ## Status >= 0
  it "should have Status of at least 0" do
    status = -1.50
    dimension = generate()
    dimension.status = status
    assert(!dimension.save, "It saves on Status less than 0")
  end
  
  ## Status <= 100
  it "should have Status of at most 100" do
    status = 100.50
    dimension = generate()
    dimension.status = status
    assert(!dimension.save, "It saves on Status more than 100")    
  end

  ### EXTRA
  
  ## Running Rspec remotely (RoR)
  ## Credit: Yong Hoon Lee
  ## Source: https://sites.google.com/a/eecs.berkeley.edu/cs169-sp13/project/setting-up-a-deployment-site
  after(:each) do
    Dimension.delete_all
  end
end
