class AddHabtmRelationships < ActiveRecord::Migration
  def change
        remove_column :indicators, :goal_id
        remove_column :projects, :indicator_id 

        create_table :goals_indicators do |t|
          t.integer :indicator_id
          t.integer :goal_id
        end

        create_table :indicators_projects do |t|
            t.integer :project_id
            t.integer :indicator_id
        end

        change_column :goals, :prereq, :text

    end
end
