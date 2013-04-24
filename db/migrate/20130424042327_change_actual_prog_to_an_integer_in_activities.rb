class ChangeActualProgToAnIntegerInActivities < ActiveRecord::Migration
  def up
    change_column :activities, :actualProg, :integer
  end

  def down
    change_column :activities, :actualProg, :string
  end
end