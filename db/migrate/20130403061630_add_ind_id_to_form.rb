class AddIndIdToForm < ActiveRecord::Migration
  def change
    add_column :forms, :indicator_id, :integer
  end
end
