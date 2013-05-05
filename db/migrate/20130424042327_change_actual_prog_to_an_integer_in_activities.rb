class ChangeActualProgToAnIntegerInActivities < ActiveRecord::Migration
  def up
    remove_column :activities, :actualProg
    add_column :activities, :actualProg, :integer
  end

  def down
    remove_column :activities, :actualProg
    add_column :activities, :actualProg, :string
  end
end