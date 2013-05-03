class AddYearlyTargetColumnsToProject < ActiveRecord::Migration
  def change
    add_column :projects, :yearly_target_cost, :text
    add_column :projects, :yearly_target_manp, :text
  end
end
