class Project < ActiveRecord::Base
  attr_accessible :actual_cost, :actual_manp, :compensation, :description, :actual_duration, :target_duration,
                  :endDate, :inplan, :name, :notes, :startDate, :status_cost, :status_global,
                  :status_manp, :status_ms, :status_notes, :status_prog, :target_cost, :target_manp,
                  :indicator_ids, :head_id, :steer_id, :user_ids, :team, :yearly_target_cost,
                  :yearly_target_manp, :short_name, :updated_at

  serialize :yearly_target_manp, Hash
  serialize :yearly_target_cost, Hash
  serialize :status_ms, Hash

  ### ASSOCIATIONS
  ## parent
  has_and_belongs_to_many :indicators
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
  
  # Needs an Owner
  validates :head_id,
  :presence => true

  # Needs a Steer
  validates :steer_id,
  :length => { :minimum => 0 },
  :allow_blank => true

  # Name = string[80]
  validates :name,
  :presence => true,
  :length => { :maximum => 80 }
  
  ## short name = string[30]
  validates :short_name,
  :presence => true,
  :length => { :maximum => 30 }
  
  ## Description = string[600]
  ## Description can be empty
  validates :description,
  :length => { :maximum => 600 },
  :presence => true

  ### TODO: NOTE TO SELF
  ## If you see this note, make sure to only give T/F options
  ## Rails has this thing where most things default to False 

  ## Inplan = true / false = yes / no
  validates :inplan, 
  :inclusion => { :in => [true, false] },
  :allow_blank => true

  ## Compensation = true / false = yes / no
  validates :compensation, 
  :inclusion => { :in => [true, false] },
  :allow_blank => true

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

  ## Target_manp = integer
  ## 0.00 <= target_manp
  validates :target_manp,
  :presence => true,
  :numericality => {
    :greater_than_or_equal_to => 0,
    :only_integer => true
  }
  
  ## Actual_manp = integer
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

  ## Status_ms =  integer
  ## 0 <= status_ms <= 8
  validates :status_ms,
            :presence => true

  validates_each :status_ms do |record,attribute,value|
    problems = ""
    if value.is_a? Hash
      value.each do |phase, progress|
        problems << "phase must be in Activity::PHASES, unlike #{phase}" unless Activity::PHASES.include? phase
        problems << "progress must be in Activity::PROGRESS, unlike #{phase}" unless Activity::PROGRESS.include? progress
        problems << "Activitiy::ONGOING must have a progress of 0" if problems == "" and phase == Activity::ONGOING and progress.nonzero?
      end
      problems << "There must be an entry for each phase" unless value.length == Activity::PHASES.length
    else
      problems << "status_ms must be a hash of phase keys to progress values"
    end
    record.errors.add(:status_ms, problems) if problems != ""
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
    elsif startDate >= endDate
      errors.add(:endDate, 'must be after start date')
    end
  end

  # Calculates actual cost from the activities claiming this project as a parent.
  # In the even there are no activities, sets this projects' cost to 0.
  def update_actual_cost
    cost = BigDecimal(0.00, 10)
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
    total_activity_days = activity.endDate - activity.startDate # Cannot be zero, by :validDate
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
        t_cost[year] += (act.targetCost * cost_fraction.fetch(year, 0))
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
        t_manp[year] += (act.targetManp * manp_fraction.fetch(year, 0))
      end
    end
    self.yearly_target_manp = t_manp
  end

  # Exclusive of the endDate, inclusive of the startDate
  def update_target_duration
    self.target_duration = self.endDate - self.startDate
  end

  # Exclusive of the today, inclusive of the startDate
  def update_actual_duration
    self.actual_duration = Date.today - self.startDate
  end

  def update_status_prog
    #update_actual_duration #TODO possibly omit this so it can be only updated if the start/end date changes.
    #update_target_duration
    self.status_prog = BigDecimal(self.actual_duration, 10) / BigDecimal(self.target_duration, 10)
  end

  def update_status_manp
    #update_actual_manp
    #update_target_manp
    if self.target_manp.zero? # TODO Decide if this should be left as zero, one, or Infinity (default behavior of BigDecimal if left without if. Check how it behaves with the database)
      self.status_manp = BigDecimal(0,10)
    else
      self.status_manp = BigDecimal(self.actual_manp, 10) / BigDecimal(self.target_manp, 10)
    end
  end

  def update_status_cost
    #update_actual_cost
    #update_target_cost
    if self.target_cost.zero? # TODO Decide if this should be left as zero, one, or Infinity (default behavior of BigDecimal if left without if. Check how it behaves with the database)
      self.status_cost = BigDecimal(0,10)
    else
      self.status_cost = BigDecimal(self.actual_cost, 10) / BigDecimal(self.target_cost, 10)
    end
  end

  # TODO decide if this should be calculated from yearly_target_manp
  def update_target_manp
    manp = 0
    self.activities.each do |activity|
      manp += activity.targetManp
    end
    self.target_manp = manp
  end

  # TODO decide if this should be calculated from yearly_target_cost
  def update_target_cost
    cost = BigDecimal(0.00, 10)
    self.activities.each do |activity|
      cost += activity.targetCost
    end
    self.target_cost = cost
  end

  def update_status_ms
    phases_progress = { }
    self.activities.each do |act|
      if act.phase != Activity::ONGOING
        if phases_progress[act.phase].nil?
          phases_progress[act.phase] = act.actualProg
        elsif phases_progress[act.phase] != act.actualProg
          phases_progress[act.phase] = Activity::IN_PROGRESS
        end
      end
    end
    # Guarantee that all phases have a value assigned.
    # This also ensures Project Management is always set to zero, as a special case. This makes calculations across the values simpler.
    Activity::PHASES.each { |phase| phases_progress[phase] = Activity::NOT_YET_STARTED if phases_progress[phase].nil? }
    self.status_ms = phases_progress
  end

  def update_all
    update_actual_duration
    update_target_duration
    update_actual_manp
    update_target_manp
    update_actual_cost
    update_target_cost
    update_yearly_target_cost
    update_yearly_target_manp
    update_status_cost
    update_status_manp
    update_status_prog
    update_status_ms
  end

end