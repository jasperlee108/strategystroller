class ChangeFreqFormatInIndicator < ActiveRecord::Migration
  def up
    remove_column :indicators, :freq
    add_column :indicators, :freq, :text
  end

  def down
    remove_column :indicators, :freq
    add_column :indicators, :freq, :string
  end
end
