class Indicator < ActiveRecord::Base
  attr_accessible :actual, :description, :diff, :dir, :freq, :year, :reported_values, :indicator_type,
                  :name, :notes, :source, :contributing_projects_status, :status, :status_notes,
                  :prognosis, :target, :unit, :goal_id, :user_id

  serialize :freq, Array
  serialize :reported_values, Array

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

  # Needs to have Parent
  validates :goal_id,
  :presence => true

  # Needs to have Owner
  validates :user_id,
  :presence => true
  
  ## Description = string[600]
  ## Description can be empty
  validates :description,
  :length => { :maximum => 600 },
  :allow_blank => true
  
  ## Source = string[200]
  validates :source,
  :presence => true,
  :length => { :maximum => 200 }

  ## Unit = string[20]
  validates :unit,
  :presence => true,
  :length => { :maximum => 20 }

  ## Freq = Array[int]
  validates :freq,
  :presence => true

  validates_each :freq do |record,attribute,value|
    problems = ""
    if value.is_a? Array
      if value.empty?
        problems << ":freq cannot be empty"
      else
        value.each do |month|
          if month < 1 or month > 12
            problems <<
                "Each month must be a value between 1 and 12, one was #{month}"
          end
          unless month.is_a? Integer
            problems <<
                "Each month must be an Integer, one was #{month} which is not an Integer"
          end
        end
      end
      if value.length > 12
        problems <<
            ":freq is too long, it should only have at most 12 elements. This had #{value.length}"
      end
    else
      problems << ":freq must be an array"
    end
    record.errors.add(:freq, problems) if problems != ""
  end

  ## Year = Integer
  validates :year,
            :presence => true,
            :numericality => { :only_integer => true}

  ## Only one indicator of a given name per year
  validates_uniqueness_of :name, :scope => :year

  ## reported values = Array[decimals]
  validates :reported_values,
            :presence => true

  validates_each :reported_values do |record,attribute,value|
    problems = ""
    if value.is_a? Array
      value.each do |v|
        if v < 0
          problems << "Each value must be a greater than or equal to 0, one was #{v}"
        end
        unless v.is_a? BigDecimal or v.is_a? Float
          problems << "Each value must be a float (to be converted into a BigDecimal) or a BigDecimal, one was #{v} which is neither"
        end
      end
      if value.length > record.freq.length
        problems << ":reported_values is too long, it should only have at most #{record.freq.length} elements. This had #{value.length}"
      end
    else
      problems << "The reported values must be an array"
    end
    record.errors.add(:reported_values, problems) if problems != ""
  end

  ## Type = string[10]
  validates :indicator_type,
  :presence => true,
  :length => { :maximum => 10 }

  ## Dir = string[20]
  validates :dir,
  :presence => true,
  :length => { :maximum => 20 }

  ## Actual = decimal
  ## 0.00 <= Actual
  validates :actual,
  :presence => true,
  :numericality => { :greater_than_or_equal_to => 0 }

  ## Target = decimal
  ## 0.00 < Target
  validates :target,
  :presence => true,
  :numericality => { :greater_than => 0 }
  
  ## Notes = string[600]
  ## Notes can be empty
  validates :notes,
  :length => { :maximum => 600 },
  :allow_blank => true
  
  ## Status = long integer
  ## 0.00 <= Status
  validates :status,
  :presence => true,
  :numericality => { :greater_than_or_equal_to => 0 }

  ## Contributing_Projects_status = long integer
  ## 0.00 <= Contributing_Projects_status
  validates :contributing_projects_status,
    :presence => true,
    :numericality => { :greater_than_or_equal_to => 0 }

  ## prognosis = long integer
  ## 0.00 <= prognosis
  validates :prognosis,
    :presence => true,
    :numericality => { :greater_than_or_equal_to => 0 }

  ## Status Notes = string[600]
  ## Notes can be empty
  validates :status_notes,
  :length => { :maximum => 600 },
  :allow_blank => true

  ## Difference = float
  ## Difference >= 0.0
  validates :diff,
  :presence => true,
  :numericality => { :greater_than_or_equal_to => 0 }
  
end
