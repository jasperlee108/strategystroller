class Form < ActiveRecord::Base
  attr_accessible :checked, :lookup, :reviewed, :user_id, :submitted, :last_reminder, :entry_id
  
  ## INFO
  GOAL = 1
  INDICATOR = 2
  PROJECT = 3
  ACTIVITY = 4
  
  ## Owner = Provider
  belongs_to :user
  
  ## Needs an owner
  validates :user_id, :presence => true
  
  ## Lookup = which table to lookup from
  ## Choices: Goal/Indicator/Project/Activity table
  validates :lookup,
  :presence => true,
  :inclusion => { :in => [GOAL, INDICATOR, PROJECT, ACTIVITY] }
  
  ### TODO: NOTE TO SELF
  ## If you see this note, make sure to only give T/F options
  ## Rails has this thing where most things default to False 

  ## Checked = true / false = yes / no
  validates :checked, :inclusion => { :in => [true, false] }
  
  ## Reviewed = true / false = yes / no
  validates :reviewed, :inclusion => { :in => [true, false] }
  
  ## Submitted = true / false = yes / no
  validates :submitted, :inclusion => { :in => [true, false] }

  ## Last reminder = date
  validate :validDate
  
  ### VALID DATE CHECKER, modified accordingly from source
  ## Credit: Gabe Hollombe, brettish
  ## Source: http://stackoverflow.com/questions/1370926/rails-built-in-datetime-validation
  ## Source: http://stackoverflow.com/questions/5665157/date-validation-in-rails
  def validDate
    if (Date.parse(last_reminder.to_s) rescue ArgumentError) == ArgumentError
      errors.add(:last_reminder, 'must be a valid date')
    end
  end

  ## Reference to the entry in table for owner
  validates :entry_id, :presence => true
end