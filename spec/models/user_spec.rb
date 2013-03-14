require 'spec_helper'

describe User do

  ### NOTE: Using ruby format, not Rspec

  SUCCESS = 1
  ERR_BAD_CREDENTIALS = -1
  ERR_USER_EXISTS = -2
  ERR_BAD_USERNAME = -3
  ERR_BAD_PASSWORD = -4
  
  ## Default
  it "should pass assert true sanity test" do
    assert(true, "Did not pass sanity check")
  end

  ### USER CREATION 
  # Add more unit tests for user creation after it's written!!
  # Just use User.new for now
  
  ## Correctly set-up user is created
  it "should be saved" do
    user = User.new(
      :name => "test",
      :password => "test",
      :company_id => 0,
      :position => 0
    )
    assert(user.save, "Correctly set-up user not saved")
  end

  ## Name is not empty
  it "should have a UserName" do
    user = User.new(
    :name => "",
    :password => "test",
    :company_id => 0,
    :position => 0
    )
    assert(!user.save, "Name is empty") #&& errCode == bad username
  end
  
  ## Name max = 128
  it "should have a name less than 128 character" do
    user = User.new(
    :name => (0...140).map{(65+rand(26)).chr}.join,
    :password => "test",
    :company_id => 0,
    :position => 1
    )
    assert(!user.save, "Name is longer than 128 characters") #&& errCode == bad username
  end

  ## Name is unique (within company)
  it "should have a unique name" do 
    user1 = User.new(
      :name => "test",
      :password => "testing",
      :company_id => 0,
      :position => 1
    )
    user2 = User.new(
      :name => "test",
      :password => "testing",
      :company_id => 0,
      :position => 0
    )
    assert(user1.save && !user2.save, "Name (within company) is not unique") #&& errCode == bad username
  end

  ## Name doesn't need to be unique (across companies)
  it "should have a nonunique name" do
    user1 = User.new(
      :name => "test",
      :password => "testing",
      :company_id => 0,
      :position => 1
    )
    user2 = User.new(
      :name => "test",
      :password => "testing",
      :company_id => 1,
      :position => 1
    )
    assert(user1.save && user2.save, "Name (across companies) is incorrectly unique")
  end

  ## Password is not empty
  it "should have a password" do
    user = User.new(
    :name => "test",
    :password => "",
    :company_id => 0,
    :position => 0
    )
    assert(!user.save, "Password is empty") #&& errCode == bad pw
  end
  
  ## Password max = 128
  it "should have a password less than 128 character" do
    user = User.new(
    :name => "test",
    :password => (0...140).map{(65+rand(26)).chr}.join,
    :company_id => 0,
    :position => 1
    )
    assert(!user.save, "Password is longer than 128 characters") #&& errCode == bad pw
  end
  
  ### USER LOGIN

  ## Correctly set-up user can log in
  it "should be able to log in" do
    User.create( #Change to creation method later
      :name => "Jelly",
      :password => "Bean",
      :company_id => 0,
      :position => 1
    ) 
    code = User.validate_login("Jelly", "Bean", 0)
    assert(code == SUCCESS, "Correct user was not able to log in")
  end

  ## Username does not exist
  it "should have a username that exists" do
    code = User.validate_login("Jelly", "Bean", 28)
    assert(code == ERR_BAD_CREDENTIALS, "User that should not exist exists")
  end

  ## Wrong Password
  it "should enter the correct password" do
    User.create( #Change to creation method later
      :name => "Jelly",
      :password => "Bean",
      :company_id => 0,
      :position => 1
    ) 
    code = User.validate_login("Jelly", "Blob", 0)
    assert(code == ERR_BAD_CREDENTIALS, "User entered wrong password")
  end

  ## Users with same name from diff companies can login with same passwords
  it "should be able to login with same pw when users in diff companies have same name" do
    User.create( #Change to creation method later
      :name => "Jelly",
      :password => "Bean",
      :company_id => 0,
      :position => 1
    ) 
    User.create( #Change to creation method later
      :name => "Jelly",
      :password => "Bean",
      :company_id => 1,
      :position => 1
    ) 
    code = User.validate_login("Jelly", "Bean", 0)
    code2 = User.validate_login("Jelly", "Bean", 1)
    assert(code == SUCCESS && code2 == SUCCESS, "users in diff companies with same name can't login with same pw")
  end

  ## Users with same name from diff companies can login with diff passwords
  it "should be able to login with diff pw when users in diff companies have same name" do
    User.create( #Change to creation method later
      :name => "Jelly",
      :password => "Blob",
      :company_id => 0,
      :position => 1
    ) 
    User.create( #Change to creation method later
      :name => "Jelly",
      :password => "Bean",
      :company_id => 1,
      :position => 1
    ) 
    code = User.validate_login("Jelly", "Blob", 0)
    code2 = User.validate_login("Jelly", "Bean", 1)
    assert(code == SUCCESS && code2 == SUCCESS, "users in diff companies with same name can't login with diff pw")
  end

  ## Users with diff names from same company can login with same password
  it "should be able to login with same pw when users in diff companies have same name" do
    User.create( #Change to creation method later
      :name => "Jelly",
      :password => "Bean",
      :company_id => 0,
      :position => 1
    ) 
    User.create( #Change to creation method later
      :name => "Jello",
      :password => "Bean",
      :company_id => 0,
      :position => 1
    ) 
    code = User.validate_login("Jelly", "Bean", 0)
    code2 = User.validate_login("Jello", "Bean", 0)
    assert(code == SUCCESS && code2 == SUCCESS, "users in same company with diff name can login with same pw")
  end

  ## Wrong Company
  it "should not be able to login to wrong company" do
    User.create( #Change to creation method later
      :name => "Jelly",
      :password => "Bean",
      :company_id => 0,
      :position => 1
    ) 
    code = User.validate_login("Jelly", "Bean", 28)
    assert(code == ERR_BAD_CREDENTIALS, "logged in to wrong company")
  end

  ### POSITION

  ## Position should be returned
  it "should return the correct position of the user" do
    User.create( #Change to creation method later
      :name => "Jelly",
      :password => "Bean",
      :company_id => 0,
      :position => 1
    ) 
    pos = User.get_position("Jelly", "Bean", 0)
    assert(pos == 1, "Wrong position returned")
  end

  ### EXTRA
  
  ## Running Rspec remotely (RoR)
  ## Credit: Yong Hoon Lee
  ## Source: https://sites.google.com/a/eecs.berkeley.edu/cs169-sp13/project/setting-up-a-deployment-site
  after(:each) do
    User.delete_all
  end

end