class AddUsersToApplication < ActiveRecord::Migration
  def change
    add_column :users, :application_id, :integer
  end
end
