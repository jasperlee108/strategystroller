require 'spec_helper'

describe Dimension do
  
  ### NOTE: Using ruby format, not Rspec
  
  ## Default
  it "should pass assert true sanity test" do
    assert(true, "Did not pass sanity check")
  end

  ## All Correct
  it "should behave correctly on good inputs" do
    dimension = Dimension.new(
    :name => "Dimension",
    :status => 75.50
    )
    assert(dimension.save, "It won't save on good inputs")
  end

  ### NAME
  
  ## Name is not empty
  it "should not have empty Name" do
    dimension = Dimension.new(
    :name => "",
    :status => 0.00
    )
    assert(!dimension.save, "It saves on empty Name")
  end
  
  ## Name max = 80
  it "should not have Name longer than 30 characters" do
    dimension = Dimension.new(
    :name => (0...31).map{ ( 65+rand(26) ).chr }.join,
    :status => 0.00
    )
    assert(!dimension.save, "It saves on Name longer than 30 characters")
  end

  ### STATUS
  
  ## Status >= 0
  it "should have Status of at least 0" do
    dimension = Dimension.new(
    :name => "Dimension",
    :status => -1.50
    )
    assert(!dimension.save, "It saves on Status less than 0")
  end
  
  ## Status <= 100
  it "should have Status of at most 100" do
    dimension = Dimension.new(
    :name => "Dimension",
    :status => 100.50
    )
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
