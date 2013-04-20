class ChangeFreqFormatInIndicator < ActiveRecord::Migration
  def up
    change_column :indicators, :freq, :text
  end

  def down
    change_column :indicators, :freq, :string
  end
end
