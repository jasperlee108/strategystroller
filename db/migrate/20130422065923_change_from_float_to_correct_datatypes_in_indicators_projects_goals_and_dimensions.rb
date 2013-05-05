class ChangeFromFloatToCorrectDatatypesInIndicatorsProjectsGoalsAndDimensions < ActiveRecord::Migration
  # AFFECTED_TABLES = [:dimensions, :goals, :indicators, :projects]
  # This change is primarily for precision purposes. Though many statuses and related values
  # will be percentages, some (cumulative Statuses) will be dollar values, and all will be used in a
  # business setting, so precision is worth the increased overhead of using decimal values.

  def up
    change_column :dimensions, :status, :decimal

    change_column :goals, :status, :decimal

    change_column :indicators, :actual, :decimal
    change_column :indicators, :target, :decimal
    change_column :indicators, :diff, :decimal
    change_column :indicators, :status, :decimal
    change_column :indicators, :contributing_projects_status, :decimal
    change_column :indicators, :prognosis, :decimal

    change_column :projects, :duration, :integer # as specified in the excel spreadsheet, duration is months as an integer (formulas document has it as days as an integer, though an integer regardless).
    change_column :projects, :status_prog, :decimal
    change_column :projects, :status_global, :decimal
  end

  def down
    change_column :dimensions, :status, :float

    change_column :goals, :status, :float

    change_column :indicators, :actual, :float
    change_column :indicators, :target, :float
    change_column :indicators, :diff, :float
    change_column :indicators, :status, :float
    change_column :indicators, :contributing_projects_status, :float
    change_column :indicators, :prognosis, :float

    change_column :projects, :duration, :float
    change_column :projects, :status_prog, :float
    change_column :projects, :status_global, :float
  end

end
