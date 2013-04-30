class CreateIndicators < ActiveRecord::Migration
  def change
    create_table :indicators do |t|
      t.string :name
      t.string :owner
      t.text :description
      t.string :source
      t.string :unit
      t.string :freq
      t.string :indicator_type
      t.string :dir
      t.float :actual
      t.float :target
      t.text :notes
      t.float :diff
      t.float :status
      t.text :status_notes

      t.timestamps
    end
  end
end
