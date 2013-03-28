class Project < ActiveRecord::Base
  attr_accessible :actual_cost, :actual_manp, :compensation, :description, :duration, :endDate, :inplan, :name, :notes, :owner, :startDate, :status_cost, :status_global, :status_manp, :status_ms, :status_notes, :status_prog, :steer, :target_cost, :target_manp, :team

  # Name = string[80]
  validates :name,
  :presence => true,
  :length => { :maximum => 80 }
  
  ## Owner = string[100] <u_id,u_string>
  validates :owner,
  :presence => true,
  :length => { :maximum => 100 }
  
  ## Description = string[600]
  ## Description can be empty
  validates :description,
  :length => { :maximum => 600 },
  :allow_blank => true
  
  ## Steer = string[20]
  validates :steer,
  :length => { :maximum => 20 }

  ## Team = string[20]
  validates :team,
  :length => { :maximum => 20 }

  ### TODO: NOTE TO SELF
  ## If you see this note, make sure to only give T/F options
  ## Rails has this thing where most things default to False 

  ## Inplan = true / false = yes / no
  validates :inplan, :inclusion => { :in => [true, false] }

  ## Compensation = true / false = yes / no
  validates :compensation, :inclusion => { :in => [true, false] }

  ## Duration = float
  ## 0.00 <= duration
  validates :duration,
  :allow_nil => true,
  :numericality => { :greater_than_or_equal_to => 0 }

  ## Target Cost = decimal
  ## 0.00 <= target_cost
  validates :target_cost,
  :allow_nil => true,
  :numericality => { :greater_than_or_equal_to => 0 }

  ## Actual Cost = decimal
  ## 0.00 <= actual_cost
  validates :actual_cost,
  :allow_nil => true,
  :numericality => { :greater_than_or_equal_to => 0 }

  ## Target_manp = long integer
  ## 0.00 <= target_manp
  validates :target_manp,
  :allow_nil => true,
  :numericality => {
    :greater_than_or_equal_to => 0,
    :only_integer => true
  }
  
  ## Actual_manp = long integer
  ## 0.00 <= actual_manp
  validates :actual_manp,
  :allow_nil => true,
  :numericality => {
    :greater_than_or_equal_to => 0,
    :only_integer => true
  }
  
  ## Status_prog = float
  ## 0.00 <= status_prog <= 100.00
  validates :status_prog,
  :allow_nil => true,
  :numericality => {
    :greater_than_or_equal_to => 0,
    :less_than_or_equal_to => 100
  }
  
  ## Status_ms = long integer
  ## 0.00 <= status_ms <= 100.00
  validates :status_ms,
  :allow_nil => true,
  :numericality => {
    :greater_than_or_equal_to => 0,
    :less_than_or_equal_to => 100
  }
  
  ## Status_manp = long integer
  ## 0.00 <= status_manp <= 100.00
  validates :status_manp,
  :allow_nil => true,
  :numericality => {
    :greater_than_or_equal_to => 0,
    :less_than_or_equal_to => 100
  }

  ## Status_cost = long integer
  ## 0.00 <= status_cost <= 100.00
  validates :status_cost,
  :allow_nil => true,
  :numericality => {
    :greater_than_or_equal_to => 0,
    :less_than_or_equal_to => 100
  }

  ## Status_global = float
  ## 0.00 <= status_global <= 100.00
  validates :status_global,
  :allow_nil => true,
  :numericality => {
    :greater_than_or_equal_to => 0,
    :less_than_or_equal_to => 100
  }
  
  ## Status_notes = string[600]
  ## Notes can be empty
  validates :status_notes,
  :length => { :maximum => 600 },
  :allow_blank => true

  ## Notes = string[600]
  ## Notes can be empty
  validates :notes,
  :length => { :maximum => 600 },
  :allow_blank => true

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

end
