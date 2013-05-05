class ChangePhaseToIntInActivity < ActiveRecord::Migration
  def up
    change_column :activities, :phase, :integer
  end

  def down
    change_column :activities, :phase, :string
  end
end
