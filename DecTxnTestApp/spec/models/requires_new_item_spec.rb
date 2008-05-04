require File.dirname(__FILE__) + '/../spec_helper'

describe RequiresNewItem do
  before(:each) do
    RequiresNewItem.delete_all    
  end

  it "should create successfully" do
    item = RequiresNewItem.create!(:name => "test item", :price => 1.0)
    
    item.reload
    item.name.should == "test item"
    item.price.should == 1.0
  end
  
  it "should change price within a txn" do
    item = RequiresNewItem.create!(:name => "test item", :price => 1.0)
    
    item.change_price(2.0)
    
    item.reload
    item.price.should == 2.0
  end
end
