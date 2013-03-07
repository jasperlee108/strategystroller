class Company < ActiveRecord::Base
  attr_accessible :id, :name
  validates :id, :presence => true, 
                    :unique => true, 
                    :numericality => {:only_integer => true},
                    :length => {:maximum => 128}
  validates :name, :presence => true,
                    :length => {:maximum => 128}
  validates_format_of :name, :with => /^\w+$/i, :message => "Name must be only letters and numbers."
end
