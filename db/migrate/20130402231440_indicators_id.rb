class IndicatorsId < ActiveRecord::Migration
  def change
    add_column :indicators, :form_id, :integer
  end
end
