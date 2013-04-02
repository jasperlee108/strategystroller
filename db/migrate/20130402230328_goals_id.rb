class GoalsId < ActiveRecord::Migration
  def change
    add_column :goals, :form_id, :integer
  end
end
