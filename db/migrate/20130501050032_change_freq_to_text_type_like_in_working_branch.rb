class ChangeFreqToTextTypeLikeInWorkingBranch < ActiveRecord::Migration
  def change
    remove_column :indicators, :freq
    add_column :indicators, :freq, :text
  end

end
