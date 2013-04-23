class ReplaceDurationWithTargetDurationAndActualDurationInProject < ActiveRecord::Migration
  def up
    add_column :projects, :target_duration, :integer
    add_column :projects, :actual_duration, :integer
    remove_column :projects, :duration
  end

  def down
    remove_column :projects, :target_duration
    remove_column :projects, :actual_duration
    add_column :projects, :duration, :integer
  end
end
