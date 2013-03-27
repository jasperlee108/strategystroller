class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.string :name
      t.text :description
      t.string :phase
      t.date :startDate
      t.date :endDate
      t.integer :targetManp
      t.decimal :targetCost
      t.text :notes
      t.integer :actualManp
      t.decimal :actualCost
      t.float :actualProg
      t.text :statusNotes

      t.timestamps
    end
  end
end
