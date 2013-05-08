# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Emanuel', :city => cities.first)

### APPLICATION
Application.create(:company => 'Default Company', :curr_year=>2013, :init_year=>2013, :language=>"English",:time_horizon=>2)

### ADMIN
AdminUser.create(
    :email => 'admin@strategystroller.com',
    :password => 'password',
    :password_confirmation => 'password'
)

### DIMENSIONS
Dimension.create(:name=>"Financial",:status=>0.0)
Dimension.create(:name=>"Customer",:status=>0.0)
Dimension.create(:name=>"Internal Process",:status=>0.0)
Dimension.create(:name=>"Learning and Growth",:status=>0.0)


### BELOW ARE FOR PRODUCTION ###

cu = User.new(
    :email => 'cu@strategystroller.com',
    :password => 'controllingunit',
    :business_code => 'JB',
    :password_confirmation => 'controllingunit',
    :controlling_unit => true,
    :username => "James Bond"
)
cu.skip_confirmation!
cu.save

provider = User.new(
    :email => 'provider@strategystroller.com',
    :password => 'provider',
    :business_code => 'AW',
    :password_confirmation => 'provider',
    :controlling_unit => false,
    :username => "Andy Warhol"
)
provider.skip_confirmation!
provider.save


### BELOW ARE FOR LOCAL DEVELOPMENT ###

#cu = User.new(
#    :email => 'cu@example.com',
#    :password => 'password',
#    :business_code => 'C1',
#    :password_confirmation => 'password',
#    :controlling_unit => true,
#    :username => "CU"
#)
#cu.skip_confirmation!
#cu.save

#provider = User.new(
#    :email => 'provider@example.com',
#    :password => 'password',
#    :business_code => 'P1',
#    :password_confirmation => 'password',
#    :controlling_unit => false,
#    :username => "Provider"
#)
#provider.skip_confirmation!
#provider.save

#jelly = User.new(
#    :email => 'jellybean@jelly.com',
#    :password => 'jellybean',
#    :business_code => 'T3',
#    :password_confirmation => 'jellybean',
#    :controlling_unit => true,
#    :username => "jelly"
#)
#jelly.skip_confirmation!
#jelly.save

#greentea = User.new(
#    :email => 'greentea@d.com',
#    :password => 'greentea',
#    :business_code => "E2",
#    :password_confirmation => 'greentea',
#    :controlling_unit => false,
#    :username => 'greentea'
#)
#greentea.skip_confirmation!
#greentea.save