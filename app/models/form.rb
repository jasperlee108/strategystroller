class Form < ActiveRecord::Base
    attr_accessible :goal_id, :indicator_id, :project_id
    has_one :goal
    has_one :indicator
    has_one :project
    has_and_belongs_to_many :users
    has_and_belongs_to_many :applications
    accepts_nested_attributes_for :users

    # Must have unique goal+indicator+project
    validates_uniqueness_of :goal_id, :scope => [:indicator_id, :project_id]
end
