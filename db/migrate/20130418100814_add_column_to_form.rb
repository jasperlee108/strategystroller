class AddColumnToForm < ActiveRecord::Migration
  def change
    add_column :forms, :submitted, :boolean
    add_column :forms, :last_reminder, :date
    add_column :forms, :entry_id, :integer
  end
end
