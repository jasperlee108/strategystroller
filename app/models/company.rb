class Company < ActiveRecord::Base
  has_many :users, :dependent => :destroy
  attr_accessible :name

  validates :name, :presence => true,
                    :length => {:maximum => 128}
  validates_uniqueness_of :name
  validates_format_of :name, :with => /^\w+$/i, :message => "Name must be only letters and numbers."
end
