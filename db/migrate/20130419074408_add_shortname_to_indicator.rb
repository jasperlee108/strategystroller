class AddShortnameToIndicator < ActiveRecord::Migration
  def change
    add_column :indicators, :short_name, :string
  end
end
