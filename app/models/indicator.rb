class Indicator < ActiveRecord::Base
  attr_accessible :actual, :description, :diff, :dir, :freq, :name, :notes, :owner, :source, :status, :status_notes, :target, :type, :unit
  
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
  
  ## Source = string[200]
  validates :source,
  :length => { :maximum => 200 }

  ## Unit = string[20]
  validates :unit,
  :length => { :maximum => 20 }

  ## Freq = string[2]
  validates :source,
  :length => { :maximum => 2 }

  ## Type = string[10]
  validates :source,
  :length => { :maximum => 10 }

  ## Dir = string[20]
  validates :dir,
  :length => { :maximum => 20 }

  ## Actual = long integer
  ## 0.00 <= Status <= 100.00
  validates :actual,
  :allow_nil => true,
  :numericality => {
    :greater_than_or_equal_to => 0,
    :less_than_or_equal_to => 100
  }

  ## Target = long integer
  ## 0.00 <= Status <= 100.00
  validates :target,
  :allow_nil => true,
  :numericality => {
    :greater_than_or_equal_to => 0,
    :less_than_or_equal_to => 100
  }
  
  ## Notes = string[600]
  ## Notes can be empty
  validates :notes,
  :length => { :maximum => 600 }
  
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
  :length => { :maximum => 600 }

end
