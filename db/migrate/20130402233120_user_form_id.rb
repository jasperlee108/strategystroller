class UserFormId < ActiveRecord::Migration
  def change
    add_column :users, :form_id, :integer
  end
end
