class Company < ActiveRecord::Base
  attr_accessible :name

  validates :name, :presence => true,
                    :length => {:maximum => 128}
  validates_format_of :name, :with => /^\w+$/i, :message => "Name must be only letters and numbers."
end
