class CreateApplications < ActiveRecord::Migration
  def change
    create_table :applications do |t|
      t.string :company
      t.integer :curr_year
      t.integer :init_year
      t.string :language
      t.integer :time_horizon

      t.timestamps
    end
  end
end
