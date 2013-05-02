class ChangeFreqToTextTypeLikeInWorkingBranch < ActiveRecord::Migration
  def change
    change_column :indicators, :freq, :text
  end

end
