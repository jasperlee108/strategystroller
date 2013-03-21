require 'spec_helper'

describe User do
  ### NOTE: Using ruby format, not Rspec
  
  ## Default
  it "should pass assert true sanity test" do
    assert(true, "Did not pass sanity check")
  end

  ## Valid new Admin
  it "should have valid Email" do
    user = User.create(
    :email => "a@a.a",
    :password => "password",
    :password_confirmation => "password"
    )
    assert(user.save, "Admin is valid")
  end

  ### EMAIL

  ## Email can't be blank
  it "should not have empty Email" do
    user = User.create(
    :email => "",
    :password => "password",
    :password_confirmation => "password"
    )
    assert(!user.save, "Email can't be blank")
  end

  ## Email is invalid: a
  it "should have valid Email" do
    user = User.create(
    :email => "a",
    :password => "password",
    :password_confirmation => "password"
    )
    assert(!user.save, "Email is invalid: " + "a")
  end

  ## Email is invalid: a@
  it "should have valid Email" do
    user = User.create(
    :email => "a@",
    :password => "password",
    :password_confirmation => "password"
    )
    assert(!user.save, "Email is invalid: " + "a@")
  end

  ## Email is invalid: a@a
  it "should have valid Email" do
    user = User.create(
    :email => "a@a",
    :password => "password",
    :password_confirmation => "password"
    )
    assert(!user.save, "Email is invalid: " + "a@a")
  end

  ## Email is invalid: a@a.
  it "should have valid Email" do
    user = User.create(
    :email => "a@a.",
    :password => "password",
    :password_confirmation => "password"
    )
    assert(!user.save, "Email is invalid: " + "a@a.")
  end

  ## Email is invalid: @a.a
  it "should have valid Email" do
    user = User.create(
    :email => "@a.a",
    :password => "password",
    :password_confirmation => "password"
    )
    assert(!user.save, "Email is invalid: " + "@a.a")
  end

  ## Email is invalid: a@.a
  it "should have valid Email" do
    user = User.create(
    :email => "a@.a",
    :password => "password",
    :password_confirmation => "password"
    )
    assert(!user.save, "Email is invalid: " + "a@.a")
  end

  ## Email is invalid: a@@a
  it "should have valid Email" do
    user = User.create(
    :email => "a@@a",
    :password => "password",
    :password_confirmation => "password"
    )
    assert(!user.save, "Email is invalid: " + "a@@a")
  end

  ### PASSWORD

  ## Password can't be blank
  it "should not have empty Password" do
    user = User.create(
    :email => "a@a.a",
    :password => "",
    :password_confirmation => ""
    )
    assert(!user.save, "Password can't be blank")
  end

  ## Password min 8 characters
  it "should have Password min 8 characters" do
    user = User.create(
    :email => "a@a.a",
    :password => "pass",
    :password_confirmation => "pass"
    )
    assert(!user.save, "Password is too short (minimum is 8 characters)")
  end
  
  ## Password must match confirmation
  it "should have matching Password and Password Confirmation" do
    user = User.create(
    :email => "a@a.a",
    :password => "password",
    :password_confirmation => "pass"
    )
    assert(!user.save, "Password doesn't match confirmation")
  end

  ## Password must match confirmation and is at least 8 characters
  it "should have matching Password and Password Confirmation with at least 8 characters" do
    user = User.create(
    :email => "a@a.a",
    :password => "pass",
    :password_confirmation => "password"
    )
    assert(!user.save, "Password doesn't match confirmation, Password is too short (minimum is 8 characters)")
  end

  ## BLANK EMAIL + INVALID PASSWORD
  
  ## Email & Password can't be blank
  it "should not have empty Email & Password" do
    user = User.create(
    :email => "",
    :password => "",
    :password_confirmation => ""
    )
    assert(!user.save, "Email can't be blank, Password can't be blank")
  end

  ## Email can't be blank, Password min 8 characters
  it "should not have empty Email and have Password min 8 characters" do
    user = User.create(
    :email => "",
    :password => "pass",
    :password_confirmation => "pass"
    )
    assert(!user.save, "Email can't be blank, Password is too short (minimum is 8 characters)")
  end
  
  ## Email can't be blank, Password must match confirmation
  it "should not have empty Email and have matching Password and Password Confirmation" do
    user = User.create(
    :email => "",
    :password => "password",
    :password_confirmation => "pass"
    )
    assert(!user.save, "Email can't be blank, Password doesn't match confirmation")
  end

  ## Email can't be blank, Password must match confirmation and is at least 8 characters
  it "should not have empty Email and have matching Password and Password Confirmation with at least 8 characters" do
    user = User.create(
    :email => "",
    :password => "pass",
    :password_confirmation => "password"
    )
    assert(!user.save, "Email can't be blank, Password doesn't match confirmation, Password is too short (minimum is 8 characters)")
  end

  ### INVALID EMAIL + INVALID PASSWORD

  ## Email is invalid, Password can't be blank
  it "should have valid email and not have empty Password" do
    user = User.create(
    :email => "random",
    :password => "",
    :password_confirmation => ""
    )
    assert(!user.save, "Email is invalid, Password can't be blank")
  end

  ## Email is invalid, Password min 8 characters
  it "should have valid email and have Password min 8 characters" do
    user = User.create(
    :email => "random",
    :password => "pass",
    :password_confirmation => "pass"
    )
    assert(!user.save, "Email is invalid, Password is too short (minimum is 8 characters)")
  end
  
  ## Email is invalid, Password must match confirmation
  it "should have valid email and have matching Password and Password Confirmation" do
    user = User.create(
    :email => "random",
    :password => "password",
    :password_confirmation => "pass"
    )
    assert(!user.save, "Email is invalid, Password doesn't match confirmation")
  end

  ## Email is invalid, Password must match confirmation and is at least 8 characters
  it "should have valid email and have matching Password and Password Confirmation with at least 8 characters" do
    user = User.create(
    :email => "random",
    :password => "pass",
    :password_confirmation => "password"
    )
    assert(!user.save, "Email is invalid, Password doesn't match confirmation, Password is too short (minimum is 8 characters)")
  end

  ### EXTRA
  
  ## Running Rspec remotely (RoR)
  ## Credit: Yong Hoon Lee
  ## Source: https://sites.google.com/a/eecs.berkeley.edu/cs169-sp13/project/setting-up-a-deployment-site
  after(:each) do
    User.delete_all
  end
end
