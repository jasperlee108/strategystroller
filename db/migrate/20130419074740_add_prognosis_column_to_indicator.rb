class AddPrognosisColumnToIndicator < ActiveRecord::Migration
  def change
    add_column :indicators, :prognosis, :float
  end
end
