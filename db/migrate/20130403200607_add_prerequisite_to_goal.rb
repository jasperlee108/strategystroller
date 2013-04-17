class AddPrerequisiteToGoal < ActiveRecord::Migration
  def change
    add_column :goals, :prereq, :string
  end
end
