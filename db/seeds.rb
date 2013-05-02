# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Emanuel', :city => cities.first)
AdminUser.create(:email => 'admin@example.com', :password => 'password', :password_confirmation => 'password')
Application.create(:company => 'Default Company', :curr_year=>2013, :init_year=>2013, :language=>"English",:time_horizon=>2)
