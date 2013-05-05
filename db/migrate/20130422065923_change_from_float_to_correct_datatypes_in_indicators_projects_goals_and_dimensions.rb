class ChangeFromFloatToCorrectDatatypesInIndicatorsProjectsGoalsAndDimensions < ActiveRecord::Migration
  # AFFECTED_TABLES = [:dimensions, :goals, :indicators, :projects]
  # This change is primarily for precision purposes. Though many statuses and related values
  # will be percentages, some (cumulative Statuses) will be dollar values, and all will be used in a
  # business setting, so precision is worth the increased overhead of using decimal values.

  def up
    remove_column :dimensions, :status

    remove_column :goals, :status

    remove_column :indicators, :actual
    remove_column :indicators, :target
    remove_column :indicators, :diff
    remove_column :indicators, :status
    remove_column :indicators, :contributing_projects_status
    remove_column :indicators, :prognosis

    remove_column :projects, :duration # as specified in the excel spreadsheet, duration is months as an integer (formulas document has it as days as an integer, though an integer regardless).
    remove_column :projects, :status_prog
    remove_column :projects, :status_global
    
    add_column :dimensions, :status, :decimal

    add_column :goals, :status, :decimal

    add_column :indicators, :actual, :decimal
    add_column :indicators, :target, :decimal
    add_column :indicators, :diff, :decimal
    add_column :indicators, :status, :decimal
    add_column :indicators, :contributing_projects_status, :decimal
    add_column :indicators, :prognosis, :decimal

    add_column :projects, :duration, :integer # as specified in the excel spreadsheet, duration is months as an integer (formulas document has it as days as an integer, though an integer regardless).
    add_column :projects, :status_prog, :decimal
    add_column :projects, :status_global, :decimal
  end

  def down
    remove_column :dimensions, :status

    remove_column :goals, :status

    remove_column :indicators, :actual
    remove_column :indicators, :target
    remove_column :indicators, :diff
    remove_column :indicators, :status
    remove_column :indicators, :contributing_projects_status
    remove_column :indicators, :prognosis

    remove_column :projects, :duration
    remove_column :projects, :status_prog
    remove_column :projects, :status_global

    add_column :dimensions, :status, :float

    add_column :goals, :status, :float

    add_column :indicators, :actual, :float
    add_column :indicators, :target, :float
    add_column :indicators, :diff, :float
    add_column :indicators, :status, :float
    add_column :indicators, :contributing_projects_status, :float
    add_column :indicators, :prognosis, :float

    add_column :projects, :duration, :float
    add_column :projects, :status_prog, :float
    add_column :projects, :status_global, :float
  end

end
