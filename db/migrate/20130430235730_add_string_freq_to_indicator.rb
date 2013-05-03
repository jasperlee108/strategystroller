class AddStringFreqToIndicator < ActiveRecord::Migration
  def change
    add_column :indicators, :string_freq, :string
  end
end
