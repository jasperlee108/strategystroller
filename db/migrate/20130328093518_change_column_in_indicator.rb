class ChangeColumnInIndicator < ActiveRecord::Migration
  def change
    change_table :indicators do |t|
      t.change :description, :text, :limit => nil
      t.change :notes, :text, :limit => nil
      t.change :status_notes, :text, :limit => nil
      t.change :diff, :float, :limit => nil
      t.change :status, :float
    end
  end
end
