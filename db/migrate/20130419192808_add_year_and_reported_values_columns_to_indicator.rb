class AddYearAndReportedValuesColumnsToIndicator < ActiveRecord::Migration
  def change
    add_column :indicators, :year, :integer
    add_column :indicators, :reported_values, :text
  end
end
