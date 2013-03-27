class Project < ActiveRecord::Base
  attr_accessible :actual_cost, :actual_manp, :compensation, :description, :duration, :end, :inplan, :name, :notes, :owner, :start, :status_cost, :status_global, :status_manp, :status_ms, :status_notes, :status_prog, :steer, :target_cost, :target_manp, :team

  # Name = string[80]
  validates :name,
  :presence => true,
  :length => { :maximum => 80 }
  
  ## Owner = string[100] <u_id,u_string>
  validates :owner,
  :presence => true,
  :length => { :maximum => 100 }
  
  ## Description = string[600]
  validates :description,
  :length => { :maximum => 600 }
  
  ## Steer = string[20]
  validates :steer,
  :length => { :maximum => 20 }

  ## Team = string[20]
  validates :team,
  :length => { :maximum => 20 }

  ## Inplan = string[4]
  validates :inplan,
  :length => { :maximum => 4 }

  ## Compensation = string[4]
  validates :compensation,
  :length => { :maximum => 4 }

  ## Duration = float
  ## 0.00 <= duration <= 100.00
  validates :duration,
  :allow_nil => true,
  :numericality => {
    :greater_than_or_equal_to => 0,
    :less_than_or_equal_to => 100
  }

  ## Target Cost = float
  ## 0.00 <= duration <= 100.00
  validates :target_cost,
  :allow_nil => true,
  :numericality => {
    :greater_than_or_equal_to => 0,
    :less_than_or_equal_to => 100
  }

  ## Actual Cose = float
  ## 0.00 <= duration <= 100.00
  validates :actual_cost,
  :allow_nil => true,
  :numericality => {
    :greater_than_or_equal_to => 0,
    :less_than_or_equal_to => 100
  }

  ## Target_manp = long integer
  ## 0.00 <= target_manp <= 100.00
  validates :target_manp,
  :allow_nil => true,
  :numericality => {
    :greater_than_or_equal_to => 0,
    :less_than_or_equal_to => 100
  }
  
  ## Actual_manp = long integer
  ## 0.00 <= actual_manp <= 100.00
  validates :actual_manp,
  :allow_nil => true,
  :numericality => {
    :greater_than_or_equal_to => 0,
    :less_than_or_equal_to => 100
  }
  ## Status_prog = long integer
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

  ## Status_global = long integer
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
  :length => { :maximum => 600 }

  ## Notes = string[600]
  ## Notes can be empty
  validates :notes,
  :length => { :maximum => 600 }

end
