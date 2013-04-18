require 'spec_helper'

describe User do
  ### NOTE: Using ruby format, not Rspec
  
  def generate
    user = User.create(
    :email => "default@email.com",
    :password => "defaultPass",
    :password_confirmation => "defaultPass",
    :business_code => "GM",
    :controlling_unit => true
    )
    return user
  end
  
  ## Default
  it "should pass assert true sanity test" do
    assert(true, "Did not pass sanity check")
  end

  ## Valid new Admin
  it "should have valid Email" do
    user = User.create(
    :email => "a@a.a",
    :password => "password",
    :password_confirmation => "password",
    :business_code => "GM"
    )
    assert(user.save, "Admin is valid")
  end

  ### EMAIL

  ## Email can't be blank
  it "should not have empty Email" do
    user = User.create(
    :email => "",
    :password => "password",
    :password_confirmation => "password",
    :business_code => "GM"
    )
    assert(!user.save, "Email can't be blank")
  end

  ## Email is invalid: a
  it "should have valid Email" do
    user = User.create(
    :email => "a",
    :password => "password",
    :password_confirmation => "password",
    :business_code => "GM"
    )
    assert(!user.save, "Email is invalid: " + "a")
  end

  ## Email is invalid: a@
  it "should have valid Email" do
    user = User.create(
    :email => "a@",
    :password => "password",
    :password_confirmation => "password",
    :business_code => "GM"
    )
    assert(!user.save, "Email is invalid: " + "a@")
  end

  ## Email is invalid: a@a
  it "should have valid Email" do
    user = User.create(
    :email => "a@a",
    :password => "password",
    :password_confirmation => "password",
    :business_code => "GM"
    )
    assert(!user.save, "Email is invalid: " + "a@a")
  end

  ## Email is invalid: a@a.
  it "should have valid Email" do
    user = User.create(
    :email => "a@a.",
    :password => "password",
    :password_confirmation => "password",
    :business_code => "GM"
    )
    assert(!user.save, "Email is invalid: " + "a@a.")
  end

  ## Email is invalid: @a.a
  it "should have valid Email" do
    user = User.create(
    :email => "@a.a",
    :password => "password",
    :password_confirmation => "password",
    :business_code => "GM"
    )
    assert(!user.save, "Email is invalid: " + "@a.a")
  end

  ## Email is invalid: a@.a
  it "should have valid Email" do
    user = User.create(
    :email => "a@.a",
    :password => "password",
    :password_confirmation => "password",
    :business_code => "GM"
    )
    assert(!user.save, "Email is invalid: " + "a@.a")
  end

  ## Email is invalid: a@@a
  it "should have valid Email" do
    user = User.create(
    :email => "a@@a",
    :password => "password",
    :password_confirmation => "password",
    :business_code => "GM"
    )
    assert(!user.save, "Email is invalid: " + "a@@a")
  end

  ### PASSWORD

  ## Password can't be blank
  it "should not have empty Password" do
    user = User.create(
    :email => "a@a.a",
    :password => "",
    :password_confirmation => "",
    :business_code => "GM"
    )
    assert(!user.save, "Password can't be blank")
  end

  ## Password min 8 characters
  it "should have Password min 8 characters" do
    user = User.create(
    :email => "a@a.a",
    :password => "pass",
    :password_confirmation => "pass",
    :business_code => "GM"
    )
    assert(!user.save, "Password is too short (minimum is 8 characters)")
  end
  
  ## Password must match confirmation
  it "should have matching Password and Password Confirmation" do
    user = User.create(
    :email => "a@a.a",
    :password => "password",
    :password_confirmation => "pass",
    :business_code => "GM"
    )
    assert(!user.save, "Password doesn't match confirmation")
  end

  ## Password must match confirmation and is at least 8 characters
  it "should have matching Password and Password Confirmation with at least 8 characters" do
    user = User.create(
    :email => "a@a.a",
    :password => "pass",
    :password_confirmation => "password",
    :business_code => "GM"
    )
    assert(!user.save, "Password doesn't match confirmation, Password is too short (minimum is 8 characters)")
  end

  ### BLANK EMAIL + INVALID PASSWORD
  
  ## Email & Password can't be blank
  it "should not have empty Email & Password" do
    user = User.create(
    :email => "",
    :password => "",
    :password_confirmation => "",
    :business_code => "GM"
    )
    assert(!user.save, "Email can't be blank, Password can't be blank")
  end

  ## Email can't be blank, Password min 8 characters
  it "should not have empty Email and have Password min 8 characters" do
    user = User.create(
    :email => "",
    :password => "pass",
    :password_confirmation => "pass",
    :business_code => "GM"
    )
    assert(!user.save, "Email can't be blank, Password is too short (minimum is 8 characters)")
  end
  
  ## Email can't be blank, Password must match confirmation
  it "should not have empty Email and have matching Password and Password Confirmation" do
    user = User.create(
    :email => "",
    :password => "password",
    :password_confirmation => "pass",
    :business_code => "GM"
    )
    assert(!user.save, "Email can't be blank, Password doesn't match confirmation")
  end

  ## Email can't be blank, Password must match confirmation and is at least 8 characters
  it "should not have empty Email and have matching Password and Password Confirmation with at least 8 characters" do
    user = User.create(
    :email => "",
    :password => "pass",
    :password_confirmation => "password",
    :business_code => "GM"
    )
    assert(!user.save, "Email can't be blank, Password doesn't match confirmation, Password is too short (minimum is 8 characters)")
  end

  ### INVALID EMAIL + INVALID PASSWORD

  ## Email is invalid, Password can't be blank
  it "should have valid email and not have empty Password" do
    user = User.create(
    :email => "random",
    :password => "",
    :password_confirmation => "",
    :business_code => "GM"
    )
    assert(!user.save, "Email is invalid, Password can't be blank")
  end

  ## Email is invalid, Password min 8 characters
  it "should have valid email and have Password min 8 characters" do
    user = User.create(
    :email => "random",
    :password => "pass",
    :password_confirmation => "pass",
    :business_code => "GM"
    )
    assert(!user.save, "Email is invalid, Password is too short (minimum is 8 characters)")
  end
  
  ## Email is invalid, Password must match confirmation
  it "should have valid email and have matching Password and Password Confirmation" do
    user = User.create(
    :email => "random",
    :password => "password",
    :password_confirmation => "pass",
    :business_code => "GM"
    )
    assert(!user.save, "Email is invalid, Password doesn't match confirmation")
  end

  ## Email is invalid, Password must match confirmation and is at least 8 characters
  it "should have valid email and have matching Password and Password Confirmation with at least 8 characters" do
    user = User.create(
    :email => "random",
    :password => "pass",
    :password_confirmation => "password",
    :business_code => "GM"
    )
    assert(!user.save, "Email is invalid, Password doesn't match confirmation, Password is too short (minimum is 8 characters)")
  end

  ### BUSINESS CODE
  
  ## Business Code can't be blank
  it "should not have empty Business Code" do
    busCode = ""
    user = generate()
    user.business_code = busCode
    assert(!user.save, "Business Code can't be blank")
  end

  ## Business Code max 2 characters
  it "should have Business Code max 2 characters" do
    busCode = "CEO"
    user = generate()
    user.business_code = busCode
    assert(!user.save, "Business Code is too long (maximum is 2 characters)")
  end

  ### CONTROLLING UNIT
  
  ## Controlling Unit = false
  ## True case is checked in All Correct test
  it "can have Controlling Unit be false" do
    controlling_unit = false
    user = generate()
    user.controlling_unit = controlling_unit
    assert(user.save, "It won't save on Controlling Unit being false")
  end

  ### EXTRA
  
  ## Running Rspec remotely (RoR)
  ## Credit: Yong Hoon Lee
  ## Source: https://sites.google.com/a/eecs.berkeley.edu/cs169-sp13/project/setting-up-a-deployment-site
  after(:each) do
    User.delete_all
  end
end
