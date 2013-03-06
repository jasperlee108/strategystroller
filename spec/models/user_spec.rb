

require 'spec_helper'

describe User do

  ### NOTE: Using ruby format, not Rspec
  
  ## Default
  it "should pass assert true sanity test" do
    assert(true, "Did not pass sanity check")
  end

  ### NAME
  
  ## Name is not empty
  it "should have a UserName" do
    goal = User.new(
    :name => "",
    :password => "test"
    )
    assert(!goal.save, "Name is empty")
  end
  
  ## Name max = 128
  it "should have a name less than 128 character" do
    goal = User.new(
    :name => (0...140).map{(65+rand(26)).chr}.join,
    :password => "test"
    )
    assert(!goal.save, "Name is longer than 128 characters")
  end
  
  ### PASSWORD 

  ## Name is not empty
  it "should have a password" do
    goal = User.new(
    :name => "test",
    :password => ""
    )
    assert(!goal.save, "Password is empty")
  end
  
  ## Password max = 128
  it "should have a password less than 128 character" do
    goal = User.new(
    :name => "test",
    :password => (0...140).map{(65+rand(26)).chr}.join
    )
    assert(!goal.save, "Password is longer than 128 characters")
  end
  ### EXTRA
  
  ## Running Rspec remotely (RoR)
  ## Credit: Yong Hoon Lee
  ## Source: https://sites.google.com/a/eecs.berkeley.edu/cs169-sp13/project/setting-up-a-deployment-site
  after(:each) do
    User.delete_all
  end

end