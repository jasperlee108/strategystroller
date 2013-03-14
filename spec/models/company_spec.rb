require 'spec_helper'

describe Company do

  ### NOTE: Using ruby format, not Rspec
  
  ## Default
  it "should pass assert true sanity test" do
    assert(true, "Did not pass sanity check")
  end

  ### NAME

  ## Correctly named company is saved
  it "should be saved" do
    company = Company.new(:name => "StratStroll275")
    assert(company.save, "Correctly named company not saved")
  end
  
  ## Name is not empty
  it "should not have empty Name" do
    company = Company.new(:name => "")
    assert(!company.save, "Name is empty")
  end
  
  ## Name max = 128
  it "should not have Name longer than 128 characters" do
    company = Company.new(:name => (0...129).map{ ( 65+rand(26) ).chr }.join)
    assert(!company.save, "Name is longer than 128 characters")
  end

  ## Name must be unique
  it "should have a unique name" do
    Company.create(:name => "StratStroll")
    company = Company.new(:name => "StratStroll")
    assert(!company.save, "Company name is not unique")
  end 

  ## Name must be alphanumeric
  it "should have an alphanumeric name" do
    company = Company.new(:name => "%!)*&^%_")
    assert(!company.save, "Name is not alphanumeric")
  end

  ### EXTRA
  
  ## Running Rspec remotely (RoR)
  ## Credit: Yong Hoon Lee
  ## Source: https://sites.google.com/a/eecs.berkeley.edu/cs169-sp13/project/setting-up-a-deployment-site
  after(:each) do
    Company.delete_all
  end
end
