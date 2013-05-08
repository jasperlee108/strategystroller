require 'spec_helper'

## INFO
GOAL = 1
INDICATOR = 2
PROJECT = 3
ACTIVITY = 4
ERROR = 5
ENTRY_ID = 1

describe ApplicationHelper do
  
  ### NOTE: Using ruby format, not Rspec
  
  ## Default
  it "should pass assert true sanity test" do
    assert(true, "Did not pass sanity check")
  end

  # Truth value: yes
  it "should return yes for true" do
    returnValue = find_truth_value(true)
    assert(returnValue == "Yes", "Did not return yes for true")
  end  
 
  # Truth value: no
  it "should return no for false" do
    returnValue = find_truth_value(false)
    assert(returnValue == "No", "Did not return no for false")
  end 

  # Find short name for goal
  it "should return short name for goal" do
    short_name = "random"
    Goal.new(:name => "a", :short_name => short_name, :dimension_id => 1, :user_id => 1,
             :need => "a", :justification => "a", :focus => "a").save
    returnValue = find_label(GOAL, ENTRY_ID)
    assert(returnValue == short_name, "Did not return short name for goal")
    Goal.delete_all
  end

  # Find short name for indicator
  it "should return short name for indicator" do
    short_name = "random"
    Indicator.new(:name => "a", :short_name => short_name, :user_id => 1, :description => "a",
                  :source => "a", :unit => "a", :indicator_type => "a", :dir => "a",
                  :actual => 1, :target => 1, :status => 1, :contributing_projects_status => 1,
                  :prognosis => 1, :diff => 1).save
    returnValue = find_label(INDICATOR, ENTRY_ID)
    assert(returnValue == short_name, "Did not return short name for indicator")
    Indicator.delete_all
  end

  # Find short name for project
  it "should return short name for project" do
    short_name = "random"
    Project.new(:name => "a", :short_name => short_name, :head_id => 1, :description => "a",
                :target_duration => 1, :actual_duration => 1, :target_cost => 1, :actual_cost => 1,
                :target_manp => 1, :actual_manp => 1, :status_prog => 1, :status_manp => 1,
                :status_cost => 1, :status_global => 1, :startDate => Date.current, :endDate => Date.tomorrow,
                :status_ms => {0 => 0, 1 => 1, 2 => 1, 3 => 1, 4 => 1}).save
    returnValue = find_label(PROJECT, ENTRY_ID)
    assert(returnValue == short_name, "Did not return short name for project")
    Project.delete_all
  end

  # Find short name for activity
  it "should return short name for activity" do
    short_name = "random"
    Activity.new(:name => "a", :short_name => short_name, :project_id => 1, :description => "a",
                 :phase => 1, :targetCost => 1, :actualCost => 1, :targetManp => 1, :actualManp => 1,
                 :actualProg => 1, :startDate => Date.current, :endDate => Date.tomorrow).save
    returnValue = find_label(ACTIVITY, ENTRY_ID)
    assert(returnValue == short_name, "Did not return short name for activity")
    Activity.delete_all
  end

  # Find short name for wrong object
  it "should return short name for wrong object" do
    returnValue = find_label(5, ENTRY_ID)
    assert((returnValue.include? "ERROR"), "Did not return short name for wrong object")
  end

  # Form type goal
  it "should return form type for goal" do
    returnValue = find_form_type(GOAL)
    assert(returnValue == "Goal", "Did not return form type for goal")
  end  

  # Form type indicator
  it "should return form type for indicator" do
    returnValue = find_form_type(INDICATOR)
    assert(returnValue == "Indicator", "Did not return form type for indicator")
  end  

  # Form type project
  it "should return form type for project" do
    returnValue = find_form_type(PROJECT)
    assert(returnValue == "Project", "Did not return form type for project")
  end  

  # Form type activity
  it "should return form type for activity" do
    returnValue = find_form_type(ACTIVITY)
    assert(returnValue == "Activity", "Did not return form type for activity")
  end  

  # Form type wrong from
  it "should return form type for wrong form" do
    returnValue = find_form_type(5)
    assert((returnValue.include? "ERROR"), "Did not return form type for wrong form")
  end  

end
