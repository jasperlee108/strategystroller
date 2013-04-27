# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Emanuel', :city => cities.first)

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

