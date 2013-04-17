class AddFinalToForms < ActiveRecord::Migration
  def change
    add_column :forms, :final, :boolean
  end
end
