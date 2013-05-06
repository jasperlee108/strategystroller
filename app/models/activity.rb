class Activity < ActiveRecord::Base
  attr_accessible :actualCost, :actualManp, :actualProg, :description, :endDate, :name, :notes,
                  :phase, :startDate, :statusNotes, :targetCost, :targetManp, :project_id,
                  :user_ids, :team, :short_name, :updated_at

  ### ASSOCIATIONS
  ## parent
  belongs_to :project

  PROJECT_MANAGEMENT = -1
  CONCEPT_COMPLETED = 1
  PREREQUISITES_FULFILLED = 2
  IMPLEMENTATION_RUNNING = 3
  PROJECT_EFFECTIVE = 4
  PHASES = [PROJECT_MANAGEMENT, CONCEPT_COMPLETED, PREREQUISITES_FULFILLED,
            IMPLEMENTATION_RUNNING, PROJECT_EFFECTIVE]


  NOT_YET_STARTED = 0
  IN_PROGRESS = 1
  COMPLETED = 2
  PROGRESS = [NOT_YET_STARTED, IN_PROGRESS, COMPLETED]
  # NOTE: The PROGRESS values are used in Project's "update_status_ms" method,
  # changing them will break it.

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
  :presence => true
  
  ## phase = Integer
  ## -1 <= phase <= 4
  # {"1-Concept completed", "2-Prerequisites fulfilled", "3-Implementation running", "4-Project effective"
  validates :phase,
  :presence => true,
  :numericality => { :only_integer => true },
  :inclusion => PHASES
  
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
    elsif startDate >= endDate
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
  
  ## actualProg = Integer
  ## can't be empty
  validates :actualProg,
  :presence => true,
  :numericality => { :only_integer => true },
  :inclusion => PROGRESS
  
  ## statusNotes = string[600]
  validates :statusNotes,
  :length => { :maximum => 600 },
  :allow_blank => true

end
