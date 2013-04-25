class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name
      t.string :owner
      t.string :steer
      t.string :description
      t.string :team
      t.date :start
      t.date :end
      t.float :duration
      t.integer :target_manp
      t.float :target_cost
      t.string :inplan
      t.string :compensation
      t.string :notes
      t.integer :actual_manp
      t.float :actual_cost
      t.integer :status_prog
      t.integer :status_ms
      t.integer :status_manp
      t.integer :status_cost
      t.integer :status_global
      t.string :status_notes

      t.timestamps
    end
  end
end
