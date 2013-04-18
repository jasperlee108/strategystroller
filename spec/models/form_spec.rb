require 'spec_helper'

describe Form do

  ### NOTE: Using ruby format, not Rspec
  
  ## INFO
  GOAL = 1
  INDICATOR = 2
  PROJECT = 3
  ACTIVITY = 4
  
  ## Generate default object
  def generate
    form = Form.new(
    :checked => true,
    :lookup => GOAL,
    :reviewed => true,
    :user_id => 1
    )
    return form
  end

  ## Default
  it "should pass assert true sanity test" do
    assert(true, "Did not pass sanity check")
  end

  ## All Correct
  it "should behave correctly on good inputs" do
    form = generate()
    assert(form.save, "It won't save on good inputs")
  end
  
  ## Lookup = Goal/Indicator/Project/Activity
  it "should not save with lookup value other than GIPA" do
    lookup = 5
    form = generate()
    form.lookup = lookup
    assert(!form.save, "It saves on lookup value other than GIPA")
  end
  
  ## Lookup = integer
  it "should not save with lookup value of string" do
    lookup = "random"
    form = generate()
    form.lookup = lookup
    assert(!form.save, "It saves on lookup value of string")
  end
  
  ## Checked = false
  ## True case is tested in All Correct test
  it "can have Checked be false" do
    checked = false
    form = generate()
    form.checked = checked
    assert(form.save, "It won't save on Checked being false")
  end

  ## Reviewed = false
  ## True case is tested in All Correct test
  it "can have Reviewed be false" do
    reviewed = false
    form = generate()
    form.reviewed = reviewed
    assert(form.save, "It won't save on Reviewed being false")
  end

  ### EXTRA
  
  ## Running Rspec remotely (RoR)
  ## Credit: Yong Hoon Lee
  ## Source: https://sites.google.com/a/eecs.berkeley.edu/cs169-sp13/project/setting-up-a-deployment-site
  after(:each) do
    Form.delete_all
  end
end
