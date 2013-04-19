class Activity < ActiveRecord::Base
  attr_accessible :actualCost, :actualManp, :actualProg, :description, :endDate, :name, :notes, :phase, :startDate, :statusNotes, :targetCost, :targetManp, :project_id, :user_ids, :team, :short_name

  ### ASSOCIATIONS
  ## parent
  belongs_to :project
  
  ## team
  validates :team,
  :length => { :maximum => 600 },
  :allow_blank => true

  ## name = string[80]
  validates :name,
  :presence => true,
  :length => { :maximum => 80 }
  
  ## short name = string[30]
  validates :short_name,
  :presence => true,
  :length => { :maximum => 30 }  
  
  # Needs a Parent
  validates :project_id,
  :presence => true
  
  ## description = string[600]
  validates :description,
  :length => { :maximum => 600 },
  :allow_blank => true
  
  ## phase = string[30]
  ## TODO: there are 4 choices here, might not need this field or change to int?
  validates :phase,
  :presence => true,
  :length => { :maximum => 30 }  
  
  ## startDate = date
  ## endDate = date
  validate :validDate
  
  ### VALID DATE CHECKER, modified accordingly from source
  ## Credit: Gabe Hollombe, brettish
  ## Source: http://stackoverflow.com/questions/1370926/rails-built-in-datetime-validation
  ## Source: http://stackoverflow.com/questions/5665157/date-validation-in-rails
  def validDate
    if (Date.parse(startDate.to_s) rescue ArgumentError) == ArgumentError
      errors.add(:startDate, 'must be a valid date')
    elsif (Date.parse(endDate.to_s) rescue ArgumentError) == ArgumentError
      errors.add(:endDate, 'must be a valid date')
    elsif startDate > endDate
      errors.add(:endDate, 'must be before start date')
    end
  end
  
  ## targetManp = integer > 0
  validates :targetManp,
  :presence => true,
  :numericality => {
    :only_integer => true,
    :greater_than => 0
  }
  
  ## targetCost = currency
  validates :targetCost,
  :presence => true,
  :numericality => { :greater_than_or_equal_to => 0 }
  
  ## notes = string[600]
  validates :notes,
  :length => { :maximum => 600 },
  :allow_blank => true
  
  ## actualManp = integer > 0
  validates :actualManp,
  :presence => true,
  :numericality => {
    :only_integer => true,
    :greater_than => 0
  }
  
  ## actualCost = currency
  validates :actualCost,
  :presence => true,
  :numericality => { :greater_than_or_equal_to => 0 }
  
  ## actualProg = string = {"1-Not yet started", "2-In progress", "3-Activity completed"}
  ## can't be empty
  validates :actualProg,
  :presence => true,
  :length => { :maximum => 30 }
  
  ## statusNotes = string[600]
  validates :statusNotes,
  :length => { :maximum => 600 },
  :allow_blank => true

end
