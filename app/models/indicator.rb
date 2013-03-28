class Indicator < ActiveRecord::Base
  attr_accessible :actual, :description, :diff, :dir, :freq, :name, :notes, :source, :status, :status_notes, :target, :type, :unit
  
  ### ASSOCIATIONS
  ## parent
  belongs_to :goal
  ## owner
  belongs_to :user
  ## children
  has_many :projects 
  
  # Name = string[80]
  validates :name,
  :presence => true,
  :length => { :maximum => 80 }
  
  ## Description = string[600]
  ## Description can be empty
  validates :description,
  :length => { :maximum => 600 },
  :allow_blank => true
  
  ## Source = string[200]
  validates :source,
  :length => { :maximum => 200 }

  ## Unit = string[20]
  validates :unit,
  :length => { :maximum => 20 }

  ## Freq = string[2]
  validates :freq,
  :length => { :maximum => 2 }

  ## Type = string[10]
  validates :type,
  :length => { :maximum => 10 }

  ## Dir = string[20]
  validates :dir,
  :length => { :maximum => 20 }

  ## Actual = float
  ## 0.00 <= Actual
  validates :actual,
  :allow_nil => true,
  :numericality => { :greater_than_or_equal_to => 0 }

  ## Target = float
  ## 0.00 <= Target
  validates :target,
  :allow_nil => true,
  :numericality => { :greater_than_or_equal_to => 0 }
  
  ## Notes = string[600]
  ## Notes can be empty
  validates :notes,
  :length => { :maximum => 600 },
  :allow_blank => true
  
  ## Status = long integer
  ## 0.00 <= Status <= 100.00
  validates :status,
  :allow_nil => true,
  :numericality => {
    :greater_than_or_equal_to => 0,
    :less_than_or_equal_to => 100
  }

  ## Status Notes = string[600]
  ## Notes can be empty
  validates :status_notes,
  :length => { :maximum => 600 },
  :allow_blank => true

  ## Difference = float
  ## Difference >= 0.0
  validates :diff,
  :allow_nil => true,
  :numericality => { :greater_than_or_equal_to => 0 }
  
end
