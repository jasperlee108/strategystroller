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

jelly = User.new(
    :email => 'jellybean@jelly.com',
    :password => 'jellybean',
    :business_code => 'T3',
    :password_confirmation => 'jellybean',
    :controlling_unit => true,
    :username => "jelly"
)
jelly.skip_confirmation!
jelly.save

greentea = User.new(
    :email => 'greentea@d.com',
    :password => 'greentea',
    :business_code => "E2",
    :password_confirmation => 'greentea',
    :controlling_unit => false,
    :username => 'greentea'
)
greentea.skip_confirmation!
greentea.save

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
