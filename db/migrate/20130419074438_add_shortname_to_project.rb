class AddShortnameToProject < ActiveRecord::Migration
  def change
    add_column :projects, :short_name, :string
  end
end
