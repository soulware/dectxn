require File.dirname(__FILE__) + '/../spec_helper'

describe Item do
  before(:each) do
    Item.delete_all    
  end
  
  it "should create successfully" do
    item = Item.create!(:name => "test item", :price => 1.0)
    
    item.reload
    item.name.should == "test item"
    item.price.should == 1.0
  end
  
  it "should change price within a txn" do
    item = Item.create!(:name => "test item", :price => 1.0)
    
    item.change_price(2.0)
    
    item.reload
    item.price.should == 2.0
  end
  
  it "should change price twice within a single txn" do
    item = Item.create!(:name => "test item")
    
    item.change_name_and_price("new name", 2.0)
    
    item.reload
    item.name.should == "new name"
    item.price.should == 2.0
  end
  
  it "should rollback transaction on raise ActiveRecord::Rollback" do
    item = Item.create!(:name => "test item", :price => 1.0)
    item.change_price_then_rollback(2.0)
    item.price.should == 2.0
    
    item.reload
    item.price.should == 1.0
  end
  
  it "should rollback multiple changes" do
    item = Item.create!(:name => "test item", :price => 1.0)
    item.change_name_and_price_then_rollback("new name", 2.0)
    
    item.reload
    item.name.should == "test item"
    item.price.should == 1.0
  end
  
  it "should rollback multiple changes on outer rollback" do
    item = Item.create!(:name => "test item", :price => 1.0)
    item.change_name_and_price_then_rollback_outer("new name", 2.0)
    
    item.reload
    item.name.should == "test item"
    item.price.should == 1.0
  end
  
  it "should apply transaction around classmethod" do
    item = Item.create!(:name => "test item", :price => 1.0)
    Item.update_name_thru_classmethod(item, "new name")
    
    item.reload
    item.name.should == "new name"
  end
  
  it "should apply transaction around classmethod calling methods" do
    item = Item.create!(:name => "test item", :price => 1.0)
    Item.update_name_thru_classmethod_nested(item, "new name")
    
    item.reload
    item.name.should == "new name"
  end
  
  it "should increase a price twice successfully" do
    item = Item.create!(:name => "test item", :price => 1.0)
    item.increase_price_twice_with_intermediate_reload(1.0, 1.0)
    
    item.reload
    item.price.should == 3.0
  end
  
  it "should find twice stuff" do
    item = Item.create!(:name => "test item", :price => 1.0)
    result1, result2 = Item.find_twice_update_first_name("test item", "new name")
    puts result1.name
    puts result2.name
  end
end
