class Project < ActiveRecord::Base
  attr_accessible :actual_cost, :actual_manp, :compensation, :description, :actual_duration, :target_duration,
                  :endDate, :inplan, :name, :notes, :startDate, :status_cost, :status_global,
                  :status_manp, :status_ms, :status_notes, :status_prog, :target_cost, :target_manp,
                  :indicator_id, :head_id, :steer_id, :user_ids, :team, :yearly_target_cost,
                  :yearly_target_manp

  serialize :yearly_target_manp, Hash
  serialize :yearly_target_cost, Hash

  ### ASSOCIATIONS
  ## parent
  belongs_to :indicator
  ## owner
  belongs_to :head, :class_name => "User", :foreign_key => :head_id
  ## steer
  belongs_to :steer, :class_name => "User", :foreign_key => :steer_id
  ## children
  has_many :activities

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

  ## target_duration = Integer
  ## 0 <= target_duration
  validates :target_duration,
  :presence => true,
  :numericality => { :greater_than_or_equal_to => 0 }

  ## actual_duration = Integer
  ## 0 <= actual_duration
  validates :actual_duration,
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
  
  ## Status_prog = decimal
  ## 0.00 <= status_prog
  validates :status_prog,
  :presence => true,
  :numericality => {
    :greater_than_or_equal_to => 0
  }
  
  ## Status_ms =  integer
  ## 0 <= status_ms <= 8
  validates :status_ms,
  :presence => true,
  :numericality => {
      :only_integer => true,
      :greater_than_or_equal_to => 0,
      :less_than_or_equal_to => 8
  }
  
  ## Status_manp = long integer
  ## 0.00 <= status_manp
  validates :status_manp,
  :presence => true,
  :numericality => {
    :greater_than_or_equal_to => 0
  }

  ## Status_cost = long integer
  ## 0.00 <= status_cost
  validates :status_cost,
  :presence => true,
  :numericality => {
    :greater_than_or_equal_to => 0
  }

  ## Status_global = decimal
  ## 0.00 <= status_global
  validates :status_global,
  :presence => true,
  :numericality => {
    :greater_than_or_equal_to => 0
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

  validates_each :yearly_target_cost do |record,attribute,value|
    problems = ""
    if value.is_a? Hash
      value.each do |year, cost|
        problems << "cost must be a BigDecimal, unlike #{cost}" unless cost.is_a? BigDecimal
        problems << "cost must be positive" unless cost >= 0.0
        if year.is_a? Integer
          unless record.startDate.nil? or record.endDate.nil? #makes sure it will still save if the start/end dates haven't been initialized yet for some reason
            problems << "year must be >= #{record.startDate.year}" unless year >= record.startDate.year
            problems << "year must be <= #{record.endDate.year}" unless year <= record.endDate.year
          end
        else
          problems << "year must be an Integer, unlike #{year}"
        end
      end
    else
      problems << "yearly_target_cost must be a hash of year keys to cost values"
    end
    record.errors.add(:yearly_target_cost, problems) if problems != ""
  end

  validates_each :yearly_target_manp do |record,attribute,value|
    problems = ""
    if value.is_a? Hash
      value.each do |year, manp|
        problems << "manp must be an BigDecimal, unlike #{manp}" unless manp.is_a? BigDecimal
        problems << "manp must be positive" unless manp >= 0.0
        if year.is_a? Integer
          unless record.startDate.nil? or record.endDate.nil? #makes sure it will still save if the start/end dates haven't been initialized yet for some reason
            problems << "year must be >= #{record.startDate.year}" unless year >= record.startDate.year
            problems << "year must be <= #{record.endDate.year}" unless year <= record.endDate.year
          end
        else
          problems << "year must be an Integer, unlike #{year}"
        end
      end
    else
      problems << "yearly_target_manp must be a hash of year keys to manp values"
    end
    record.errors.add(:yearly_target_manp, problems) if problems != ""
  end

  
  
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
      errors.add(:endDate, 'must be after start date')
    end
  end

  # Calculates actual cost from the activities claiming this project as a parent.
  # In the even there are no activities, sets this projects' cost to 0.
  def update_actual_cost
    cost = 0.00
    self.activities.each do |activity|
      cost += activity.actualCost
    end
    self.actual_cost = cost
  end

  def update_actual_manp
    manp = 0
    self.activities.each do |activity|
      manp += activity.actualManp
    end
    self.actual_manp = manp
  end

  # returns a hash of (year, zero-BigDecimal) with one year for each year this project spans.
  def initialized_year_hash
    year_in_range = self.startDate.year
    year_hash = {}
    while year_in_range <= self.endDate.year
      year_hash[year_in_range] = BigDecimal(0.0, 10)
      year_in_range += 1
    end
    year_hash
  end

  # given an activity, returns a hash of (year, fraction of activity's time)
  # across the activity's start and end dates.
  # Note this is inclusive of the startDate, exclusive of the endDate.
  def activity_year_fractions_hash(activity)
    year_fractions = {}
    total_activity_days = activity.endDate - activity.startDate
    range_start = activity.startDate
    while range_start.year < activity.endDate.year
      range_end = Date.new(range_start.year + 1)
      year_fractions[range_start.year] = ((range_end - range_start) / total_activity_days)
      range_start = range_end
    end
    year_fractions[range_start.year] = ((activity.endDate - range_start) / total_activity_days)
    year_fractions
  end
  
  
  def update_yearly_target_cost
    t_cost = initialized_year_hash()
    acts = self.activities
    acts.each do |act|
      cost_fraction = activity_year_fractions_hash(act)
      t_cost.keys.each do |year|
        t_cost[year] += (act.target_cost * cost_fraction.fetch(year, 0))
      end
    end
    self.yearly_target_cost = t_cost
  end

  def update_yearly_target_manp
    t_manp = initialized_year_hash()
    acts = self.activities
    acts.each do |act|
      manp_fraction = activity_year_fractions_hash(act)
      t_manp.keys.each do |year|
        t_manp[year] += (act.target_manp * manp_fraction.fetch(year, 0))
      end
    end
    self.yearly_target_manp = t_manp
  end

end