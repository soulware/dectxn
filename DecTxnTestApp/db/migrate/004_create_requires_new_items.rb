class CreateRequiresNewItems < ActiveRecord::Migration
  def self.up
    create_table :requires_new_items do |t|
      t.string :name
      t.float :price
      
      t.timestamps
    end
  end

  def self.down
    drop_table :requires_new_items
  end
end
