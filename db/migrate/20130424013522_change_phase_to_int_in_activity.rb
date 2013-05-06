class ChangePhaseToIntInActivity < ActiveRecord::Migration
  def up
    remove_column :activities, :phase
    add_column :activities, :phase, :integer
  end

  def down
    remove_column :activities, :phase
    add_column :activities, :phase, :string
  end
end
