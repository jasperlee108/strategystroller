class Goal < ActiveRecord::Base
  attr_accessible :focus, :justification, :name, :need, :notes, :status,
                  :dimension_id, :prereq, :short_name, :user_id, :updated_at, :indicators
  

  serialize :prereq, Array
  ### ASSOCIATIONS
  ## parent
  belongs_to :dimension
  ## owner
  belongs_to :user
  ## children
  has_and_belongs_to_many :indicators
  
  ## Needs to have Parent
  validates :dimension_id,
  :presence => true

  ## Needs to have Owner
  validates :user_id,
  :presence => true

  ## Name = string[80]
  validates :name,
  :presence => true,
  :length => { :maximum => 80 }
  
  ## short name = string[30]
  validates :short_name,
  :presence => true,
  :length => { :maximum => 30 }
  
  ## Need = string[1200]
  validates :need,
  :length => { :maximum => 1200 },
  :presence => true
  
  ## Justification = string[1200]
  validates :justification,
  :length => { :maximum => 1200 },
  :presence => true
  
  ## Focus = string[1200]
  validates :focus,
  :length => { :maximum => 1200 },
  :presence => true
  
  ## Notes = string[600]
  ## Notes can be empty
  validates :notes,
  :length => { :maximum => 600 },
  :allow_blank => true
  
  ## Status = decimal
  ## 0.00 <= Status
  validates :status,
  :allow_blank => true,
  :numericality => { :greater_than_or_equal_to => 0 }
  
  ## Prereq = string[80]
  ## Can have zero pre-req if it's the first
  validates :prereq, # TODO make this an array
  :length => { :maximum => 80 }

  def update_status
    inds = self.indicators
    if inds.size == 0
      self.status=0.0
    else
      status = 0.0
      inds.each do |indicator|
        status += indicator.contributing_projects_status
      end
      self.status = status / inds.size
    end
  end

  def update_all
    self.indicators.each { |indicator| indicator.update_all }
    update_status
  end

end