class ChangeColumnInActivity < ActiveRecord::Migration
  def change
    change_table :activities do |t|
      t.change :actualProg, :string, :limit => nil
    end
  end
end
