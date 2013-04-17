class Project < ActiveRecord::Base
  attr_accessible :actual_cost, :actual_manp, :compensation, :description, :duration, :endDate, :inplan, :name, :notes, :startDate, :status_cost, :status_global, :status_manp, :status_ms, :status_notes, :status_prog, :target_cost, :target_manp, :indicator_id, :head_id, :steer_id, :form_id, :user_ids, :team

  ### ASSOCIATIONS
  ## parent
  belongs_to :indicator
  ## owner
  belongs_to :head, :class_name => "User", :foreign_key => :head_id
  ## steer
  belongs_to :steer, :class_name => "User", :foreign_key => :steer_id
  ## children
  has_many :activities

  belongs_to :form

  # Team = string[600]
  validates :team,
  :length => { :maximum => 600 },
  :allow_blank => true
  
  # Needs a Parent
  validates :indicator_id,
  :presence => true

  # Needs an Owner
  validates :head_id,
  :presence => true

  # Needs a Steer
  validates :steer_id,
  :presence => true

  # Name = string[80]
  validates :name,
  :presence => true,
  :length => { :maximum => 80 }
  
  ## Description = string[600]
  ## Description can be empty
  validates :description,
  :length => { :maximum => 600 },
  :allow_blank => true

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
  :presence => true,
  :numericality => { :greater_than_or_equal_to => 0 }

  ## Target Cost = decimal
  ## 0.00 <= target_cost
  validates :target_cost,
  :presence => true,
  :numericality => { :greater_than_or_equal_to => 0 }

  ## Actual Cost = decimal
  ## 0.00 <= actual_cost
  validates :actual_cost,
  :presence => true,
  :numericality => { :greater_than_or_equal_to => 0 }

  ## Target_manp = long integer
  ## 0.00 <= target_manp
  validates :target_manp,
  :presence => true,
  :numericality => {
    :greater_than_or_equal_to => 0,
    :only_integer => true
  }
  
  ## Actual_manp = long integer
  ## 0.00 <= actual_manp
  validates :actual_manp,
  :presence => true,
  :numericality => {
    :greater_than_or_equal_to => 0,
    :only_integer => true
  }
  
  ## Status_prog = float
  ## 0.00 <= status_prog <= 100.00
  validates :status_prog,
  :presence => true,
  :numericality => {
    :greater_than_or_equal_to => 0,
    :less_than_or_equal_to => 100
  }
  
  ## Status_ms = long integer
  ## 0.00 <= status_ms <= 100.00
  validates :status_ms,
  :presence => true,
  :numericality => {
    :greater_than_or_equal_to => 0,
    :less_than_or_equal_to => 100
  }
  
  ## Status_manp = long integer
  ## 0.00 <= status_manp <= 100.00
  validates :status_manp,
  :presence => true,
  :numericality => {
    :greater_than_or_equal_to => 0,
    :less_than_or_equal_to => 100
  }

  ## Status_cost = long integer
  ## 0.00 <= status_cost <= 100.00
  validates :status_cost,
  :presence => true,
  :numericality => {
    :greater_than_or_equal_to => 0,
    :less_than_or_equal_to => 100
  }

  ## Status_global = float
  ## 0.00 <= status_global <= 100.00
  validates :status_global,
  :presence => true,
  :numericality => {
    :greater_than_or_equal_to => 0,
    :less_than_or_equal_to => 100
  }
  
  ## Status_notes = string[600]
  ## Status_notes can be empty
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
