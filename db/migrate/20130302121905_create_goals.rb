class CreateGoals < ActiveRecord::Migration
  def change
    create_table :goals do |t|
      t.string :name
      t.string :need
      t.string :justification
      t.string :focus
      t.string :notes
      t.float :status

      t.timestamps
    end
  end
end
