class AddBusinessCodeToUsers < ActiveRecord::Migration
  def change
    add_column :users, :business_code, :integer
  end
end
