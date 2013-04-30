class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name
      t.string :owner
      t.string :steer
      t.text :description
      t.text :team
      t.date :startDate
      t.date :endDate
      t.float :duration
      t.integer :target_manp
      t.decimal :target_cost
      t.boolean :inplan
      t.boolean :compensation
      t.text :notes
      t.integer :actual_manp
      t.decimal :actual_cost
      t.float :status_prog
      t.integer :status_ms
      t.integer :status_manp
      t.decimal :status_cost
      t.float :status_global
      t.text :status_notes

      t.timestamps
    end
  end
end
