class Form < ActiveRecord::Base
    #has_one not working, so changing to has_many for now
    has_many :goals
    has_many :indicators
    has_many :projects
    has_and_belongs_to_many :users
    has_and_belongs_to_many :applications
end
