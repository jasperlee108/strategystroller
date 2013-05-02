class AddSpecialFreqToIndicator < ActiveRecord::Migration
  def change
    add_column :indicators, :special_freq, :string
  end
end
