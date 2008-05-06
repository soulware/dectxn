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
  
  it "should raise RequiresNewException for nested transactions" do
    item = RequiresNewItem.create!(:name => "test item", :price => 1.0)
    lambda {item.change_name_and_price("new name", 2.0)}.should raise_error(Txn::RequiresNewException)
  end
  
  it "should rollback name change on exception for nested transactions" do
    item = RequiresNewItem.create!(:name => "test item", :price => 1.0)
    
    lambda {item.change_name_and_price("new name", 2.0)}.should raise_error(Txn::RequiresNewException)
    
    item.reload
    item.name.should == "test item"
  end
  
  it "should rollback before price change for nested transactions" do
    item = RequiresNewItem.create!(:name => "test item", :price => 1.0)
    
    lambda {item.change_name_and_price("new name", 2.0)}.should raise_error(Txn::RequiresNewException)
    
    item.reload    
    item.price.should == 1.0
  end
end
