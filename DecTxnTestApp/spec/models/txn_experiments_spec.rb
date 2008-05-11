require File.dirname(__FILE__) + '/../spec_helper'

describe Item do
  it "should increment open_transactions" do
    Item.new.transaction do
      Thread.current['open_transactions'].should == 1
    end
  end

  it "should end with 0 open_transactions" do
    Item.new.transaction do
      # empty
    end
  
    Thread.current['open_transactions'].should == 0
  end
  
  it "should increment open_transactions twice" do
    Item.new.transaction do
      Item.new.transaction do
        Thread.current['open_transactions'].should == 2
      end
    end
  end
  
  it "should increment open_transactions twice" do
    User.new.transaction do
      Item.new.transaction do
        Thread.current['open_transactions'].should == 2
      end
    end
  end
  
  it "should end with 0 open_transactions" do
    Item.new.transaction do
      Item.new.transaction do
        # empty
      end
    end
  
    Thread.current['open_transactions'].should == 0
  end
 
  it "should end with 0 open_transactions" do
    Item.new.transaction do
      User.new.transaction do
        # empty
      end
    end
  
    Thread.current['open_transactions'].should == 0
  end
 
  it "should set start_db_transaction == true" do
    Item.new.transaction do
      Thread.current['start_db_transaction'].should == true
    end
  end 
  
  it "should set start_db_transaction == false" do
    Item.new.transaction do
      Item.transaction do
        Thread.current['start_db_transaction'].should == false
      end
    end
  end
end