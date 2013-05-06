require 'spec_helper'

## INFO
GOAL = 1
INDICATOR = 2
PROJECT = 3
ERROR = 4
ENTRY_ID = 1
FORM_ID = 1

describe ControllerUnitHelper do
  
  ### NOTE: Using ruby format, not Rspec
  
  ## Default
  it "should pass assert true sanity test" do
    assert(true, "Did not pass sanity check")
  end
  
  ## Goal path
  it "redirect to Goal path" do
    path = find_path_cu(GOAL, ENTRY_ID, FORM_ID)
    assert(path == goal_check_path(:entry_id => ENTRY_ID, :form_id => FORM_ID), "Wrong path taken!")
  end

  ## Indicator path
  it "redirect to Indicator path" do
    path = find_path_cu(INDICATOR, ENTRY_ID, FORM_ID)
    assert(path == indicator_check_path(:entry_id => ENTRY_ID, :form_id => FORM_ID), "Wrong path taken!")
  end

  ## Project path
  it "redirect to Project path" do
    path = find_path_cu(PROJECT, ENTRY_ID, FORM_ID)
    assert(path == project_check_path(:entry_id => ENTRY_ID, :form_id => FORM_ID), "Wrong path taken!")
  end
  
  ## Wrong path
  it "redirect to Wrong path" do
    path = find_path_cu(ERROR, ENTRY_ID, FORM_ID)
    assert(path == cu_review_path, "Wrong path taken!")
  end
  
end
