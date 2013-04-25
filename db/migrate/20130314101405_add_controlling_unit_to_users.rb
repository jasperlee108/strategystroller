class AddControllingUnitToUsers < ActiveRecord::Migration
  def change
    add_column :users, :controlling_unit, :boolean, :default => false
  end
end
