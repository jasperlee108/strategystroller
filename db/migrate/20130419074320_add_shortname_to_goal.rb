class AddShortnameToGoal < ActiveRecord::Migration
  def change
    add_column :goals, :short_name, :string
  end
end
