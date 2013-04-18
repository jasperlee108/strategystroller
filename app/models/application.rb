class Application < ActiveRecord::Base

  attr_accessible :company, :curr_year, :curr_qtr, :curr_month,:init_year, 
  :language, :time_horizon, :users
  has_many :users
  accepts_nested_attributes_for :users

  YEARS = [2010, 2011, 2012, 2013, 2014, 2015, 2016, 2017, 2018, 2019, 2020,
    2021, 2022, 2023, 2024, 2025]

  LANGUAGES = ["English", "German"]

  TIME_HORIZON = [2,3,4,5]

  # company
  validates :company,
  :presence => true
  
  # curr_year
  validates :curr_year,
  :presence => true
  # validate valid year?
  
  # init_year
  validates :init_year,
  :presence => true
  # validate valid year?
  
  # language
  validates :language,
  :presence => true
  # Only English and German?
  
  # time_horizon
  validates :time_horizon,
  :presence => true
end
