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
end
