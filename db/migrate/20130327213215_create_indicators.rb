class CreateIndicators < ActiveRecord::Migration
  def change
    create_table :indicators do |t|
      t.string :name
      t.string :owner
      t.string :description
      t.string :source
      t.string :unit
      t.string :freq
      t.string :type
      t.string :dir
      t.float :actual
      t.float :target
      t.string :notes
      t.string :diff
      t.integer :status
      t.string :status_notes

      t.timestamps
    end
  end
end
