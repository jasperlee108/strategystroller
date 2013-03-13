class RenameUserCompanyToUserCompanyId < ActiveRecord::Migration
  def change
    add_column :users, :company_id, :integer
    #for each user
    User.all.each {|person| 
        company = Company.find_by_name(person[:company])
        person.company_id = company.id
        }
    remove_column :users, :company
  end
end
