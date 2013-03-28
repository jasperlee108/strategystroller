class RenameColumnInProject < ActiveRecord::Migration
  def change
    change_table :projects do |t|
      t.rename :start, :startDate
      t.rename :end, :endDate
      t.change :description, :text, :limit => nil
      t.change :notes, :text, :limit => nil
      t.change :status_notes, :text, :limit => nil
      t.change :status_prog, :float
      t.change :status_global, :float
      t.change :target_cost, :decimal
      t.change :actual_cost, :decimal
      t.change :status_cost, :decimal
      t.change :inplan, :boolean, :limit => nil
      t.change :compensation, :boolean, :limit => nil
    end
  end
end
