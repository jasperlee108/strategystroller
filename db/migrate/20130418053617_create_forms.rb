class CreateForms < ActiveRecord::Migration
  def change
    create_table :forms do |t|
      t.integer :lookup
      t.integer :user_id
      t.boolean :checked
      t.boolean :reviewed

      t.timestamps
    end
  end
end
