class FormUsersTimestamp < ActiveRecord::Migration
  def change
    remove_column :forms_users, :created_at, :updated_at
  end
end
