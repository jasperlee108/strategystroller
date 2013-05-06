class Indicator < ActiveRecord::Base
  attr_accessible :actual, :description, :diff, :dir, :freq, :year, :reported_values, :indicator_type,
                  :name, :notes, :source, :contributing_projects_status, :status, :status_notes,
                  :prognosis, :target, :unit, :goal_ids, :project_ids, :user_id, :short_name, :string_freq, :updated_at

  serialize :freq, Array
  serialize :reported_values, Array

  ### ASSOCIATIONS
  ## parent
  has_and_belongs_to_many :goals
  ## owner
  belongs_to :user
  ## children
  has_and_belongs_to_many :projects 
  
  # Name = string[80]
  validates :name,
  :presence => true,
  :length => { :maximum => 80 }

  ## short name = string[30]
  validates :short_name,
  :presence => true,
  :length => { :maximum => 30 }

  # Needs to have Parent
  #validates :goal_id,
  #:presence => true

  # Needs to have Owner
  validates :user_id,
  :presence => true
  
  ## Description = string[600]
  ## Description can be empty
  validates :description,
  :length => { :maximum => 600 },
  :presence => true
  
  ## Source = string[200]
  validates :source,
  :presence => true,
  :length => { :maximum => 200 }

  ## Unit = string[20]
  validates :unit,
  :presence => true,
  :length => { :maximum => 20 }

  ## Freq = Array[int]
  validates_each :freq do |record,attribute,value|
    problems = ""
    if value.is_a? Array
      if value.empty?
        # problems << ":freq cannot be empty"
      else
        value.each do |month|
          month = month
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
            :allow_blank => true,
            :numericality => { :only_integer => true}

  ## Only one indicator of a given name per year
  validates_uniqueness_of :name, :scope => :year

  ## reported values = Array[decimals]
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

  # TODO I've realized actual == prognosis at 12 months, and a slight variation on prognosis for earlier periods. Not from formulas, but should be added and updated later, with an update function.
  ## Actual = decimal
  ## 0.00 <= Actual
  validates :actual,
  :presence => true,
  :numericality => { :greater_than_or_equal_to => 0 }

  ## Target = decimal
  ## 0.00 < Target
  validates :target,
  :presence => true,
  :numericality => { :greater_than_or_equal_to => 0 }
  
  ## Notes = string[600]
  ## Notes can be empty
  validates :notes,
  :length => { :maximum => 600 },
  :allow_blank => true
  
  ## Status = decimal
  ## 0.00 <= Status
  validates :status,
  :presence => true,
  :numericality => { :greater_than_or_equal_to => 0 }

  ## Contributing_Projects_status = decimal
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

  ## Difference = decimal
  validates :diff,
  :presence => true,
  :numericality => true

  # Gives the prognosis of how the year is progressing, as specified.
  # This assumes all values that should be included in this prognosis calculation are already
  # reported (and thus in :reported_values)
  def update_prognosis
    r_values = self.reported_values
    if r_values.empty?
      self.prognosis = 0.0
    else
      sum = BigDecimal.new(r_values.reduce(:+), 10)
      if self.indicator_type == "average"
        self.prognosis = sum / r_values.length
      elsif self.indicator_type == "cumulative"
        self.prognosis = sum*12.0 / Time.now.month
      else
        raise "indicator type has not yet been set"
      end
    end
  end

  def update_diff
    #update_prognosis
    self.diff = self.prognosis - self.target
  end

  # Note this triggers calls to update_diff and update_prognosis,
  # so the calculation should be based on accurate values.
  def update_status
    #update_diff
    #raise "Target value must be nonzero, instead of #{self.target}" if self.target == 0.0
    raise "Direction must be set for this to be calculated" if self.dir.nil?
    if self.target == 0
      self.status=999999999999999 #functionally infinite
    elsif self.dir == "More is Better"
      self.status=((1 + self.diff) / self.target)
    elsif  self.dir == "Less is Better"
      self.status=((1 - self.diff) / self.target)
    end
  end

  def update_contributing_projects_status # TODO possibly add call chain to update all values this depends on
    projs = self.projects
    if projs.size == 0
      self.contributing_projects_status = 0.0
    else
      status = 0.00
      self.projects.each do |project|
        status += project.status_global
      end
      self.contributing_projects_status = status / projs.size
    end
  end

  def update_all
    self.projects.each { |project| project.update_all }
    update_prognosis
    update_diff
    update_status
    update_contributing_projects_status
  end

end
