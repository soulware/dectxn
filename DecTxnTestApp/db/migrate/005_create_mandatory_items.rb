class CreateMandatoryItems < ActiveRecord::Migration
  def self.up
    create_table :mandatory_items do |t|
      t.string :name
      t.float :price
      
      t.timestamps
    end
  end

  def self.down
    drop_table :mandatory_items
  end
end
