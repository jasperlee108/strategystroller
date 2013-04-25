class CreateDimensions < ActiveRecord::Migration
  def change
    create_table :dimensions do |t|
      t.string :name
      t.float :status

      t.timestamps
    end
    
    ## Create the default 4 dimensions
    Dimension.new(:name=>"Financial",:status=>0.0).save
    Dimension.new(:name=>"Customer",:status=>0.0).save
    Dimension.new(:name=>"Internal Process",:status=>0.0).save
    Dimension.new(:name=>"Learning and Growth",:status=>0.0).save
  end
end
