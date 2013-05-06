require 'spec_helper'

## INFO
GOAL = 1
INDICATOR = 2
PROJECT = 3
ERROR = 4
ENTRY_ID = 1
FORM_ID = 1

describe ProviderHelper do
  
  ### NOTE: Using ruby format, not Rspec
  
  ## Default
  it "should pass assert true sanity test" do
    assert(true, "Did not pass sanity check")
  end
  
  ## Goal path
  it "redirect to Goal path" do
    path = find_path(GOAL, ENTRY_ID, FORM_ID)
    assert(path == goal_define_path(:entry_id => ENTRY_ID, :form_id => FORM_ID), "Wrong path taken!")
  end

  ## Indicator path
  it "redirect to Indicator path" do
    path = find_path(INDICATOR, ENTRY_ID, FORM_ID)
    assert(path == indicator_define_path(:entry_id => ENTRY_ID, :form_id => FORM_ID), "Wrong path taken!")
  end

  ## Project path
  it "redirect to Project path" do
    path = find_path(PROJECT, ENTRY_ID, FORM_ID)
    assert(path == project_define_path(:entry_id => ENTRY_ID, :form_id => FORM_ID), "Wrong path taken!")
  end
  
  ## Wrong path
  it "redirect to Wrong path" do
    path = find_path(ERROR, ENTRY_ID, FORM_ID)
    assert(path == forms_composite_path, "Wrong path taken!")
  end

  ## Indicator update path
  it "redirect to Indicator update path" do
    path = find_update_path(INDICATOR, ENTRY_ID, FORM_ID)
    assert(path == indicator_update_path(:entry_id => ENTRY_ID, :form_id => FORM_ID), "Wrong update path taken!")
  end

  ## Project update path
  it "redirect to Project update path" do
    path = find_update_path(PROJECT, ENTRY_ID, FORM_ID)
    assert(path == project_update_path(:entry_id => ENTRY_ID, :form_id => FORM_ID), "Wrong update path taken!")
  end
  
  ## Wrong update path
  it "redirect to Wrong update path" do
    path = find_update_path(ERROR, ENTRY_ID, FORM_ID)
    assert(path == forms_composite_update_path, "Wrong update path taken!")
  end
 
end
