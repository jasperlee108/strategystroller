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
    :user_id => 1,
    :submitted => true,
    :last_reminder => Date.new(2013,04,18)
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
  
  ## Submitted = false
  ## True case is tested in All Correct test
  it "can have Submitted be false" do
    submitted = false
    form = generate()
    form.submitted = submitted
    assert(form.save, "It won't save on Submitted being false")
  end

  ## Last Reminder is a valid date
  it "should have valid Last Reminder Date" do
    last_reminder = "random"
    form = generate()
    form.last_reminder = last_reminder
    assert(!form.save, "It saves on invalid Last Reminder Date")
  end

  ## Date doesn't have February 30th
  # NOTE: date is in string, the validator will check its correctness,
  # if not, it will error out before even reaching the validator
  it "should have real Last Reminder Date" do
    last_reminder = "2013-02-30"
    form = generate()
    form.last_reminder = last_reminder
    assert(!form.save, "It saves on non existence Last Reminder Date")
  end

  ### EXTRA
  
  ## Running Rspec remotely (RoR)
  ## Credit: Yong Hoon Lee
  ## Source: https://sites.google.com/a/eecs.berkeley.edu/cs169-sp13/project/setting-up-a-deployment-site
  after(:each) do
    Form.delete_all
  end
end
