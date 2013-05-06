# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Emanuel', :city => cities.first)
Application.create(:company => 'Default Company', :curr_year=>2013, :init_year=>2013, :language=>"English",:time_horizon=>2)


AdminUser.create(
    :email => 'admin@example.com',
    :password => 'password',
    :password_confirmation => 'password'
)

cu = User.new(
    :email => 'cu@example.com',
    :password => 'password',
    :business_code => 'C1',
    :password_confirmation => 'password',
    :controlling_unit => true,
    :username => "CU"
)
cu.skip_confirmation!
cu.save

provider = User.new(
    :email => 'provider@example.com',
    :password => 'password',
    :business_code => 'P1',
    :password_confirmation => 'password',
    :controlling_unit => false,
    :username => "Provider"
)
provider.skip_confirmation!
provider.save

### DIMENSIONS

Dimension.create(:name =>"financial", :status => 0.0)
Dimension.create(:name =>"customer", :status => 0.0)
Dimension.create(:name =>"internal process", :status => 0.0)
Dimension.create(:name =>"learning & growth", :status => 0.0)

Goal.create(
    :name => "Goal0",
    :need => "Call for action",
    :justification => "Justification of specific goal",
    :focus => "Strategic approach",
    :notes => "Notes",
    :status => 0.01,
    :dimension_id => 1,
    :user_id => 2,
    :prereq => "A Different Goal's Name",
    :short_name => "G0"
)

Indicator.create(
    :name => "Indicator0",
    :description => "Beschreibung der Messgrobe",
    :source => "Quelle",
    :unit => "Einheit",
    :freq => [3,6,9,12],
    :year => 2013,
    :reported_values => [0.2, 0.65],
    :indicator_type => "average",
    :prognosis => 0.6543,
    :dir => "more is better",
    :actual => 0.55,
    :target => 0.105,
    :notes => "Anmerkungen",
    :diff => 0.05,
    :status => 0.755,
    :contributing_projects_status => 0.693,
    :status_notes => "Anmerkungen zum Status",
    :goal_id => 1,
    :user_id => 2,
    :short_name => "I0"
)
