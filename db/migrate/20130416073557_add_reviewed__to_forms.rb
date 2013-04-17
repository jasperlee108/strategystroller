class AddReviewedToForms < ActiveRecord::Migration
  def change
    add_column :forms, :reviewed, :boolean
  end
end
