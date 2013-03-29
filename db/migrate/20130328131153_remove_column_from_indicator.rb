class RemoveColumnFromIndicator < ActiveRecord::Migration
  def up
    remove_column :indicators, :owner
  end

  def down
    add_column :indicators, :owner, :string
  end
end
