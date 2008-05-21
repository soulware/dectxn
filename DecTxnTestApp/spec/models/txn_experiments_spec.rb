require File.dirname(__FILE__) + '/../spec_helper'

describe Item do
  it "should increment open_transactions" do
    Item.transaction do
      Thread.current['open_transactions'].should == 1
    end
  end

  it "should end with 0 open_transactions" do
    Item.transaction do
      # empty
    end
  
    Thread.current['open_transactions'].should == 0
  end
  
  it "should increment open_transactions twice" do
    Item.transaction do
      Item.transaction do
        Thread.current['open_transactions'].should == 2
      end
    end
  end
  
  it "should increment open_transactions twice" do
    User.transaction do
      Item.transaction do
        Thread.current['open_transactions'].should == 2
      end
    end
  end
  
  it "should end with 0 open_transactions" do
    Item.transaction do
      Item.transaction do
        # empty
      end
    end
  
    Thread.current['open_transactions'].should == 0
  end
 
  it "should end with 0 open_transactions" do
    Item.transaction do
      User.transaction do
        # empty
      end
    end
  
    Thread.current['open_transactions'].should == 0
  end
 
  it "should set start_db_transaction == true" do
    Item.transaction do
      Thread.current['start_db_transaction'].should == true
    end
  end 
  
  it "should set start_db_transaction == false" do
    Item.transaction do
      Item.transaction do
        Thread.current['start_db_transaction'].should == false
      end
    end
  end
  
  it "should safely start a new transaction in a thread" do
    t = Thread.new("test") { |x|
      Item.transaction do
        Thread.current['open_transactions'].should == 1
      end
    }
    
    t.join
  end
  
  it "should blow up as sqlite is effectively single-threaded (lock on whole db...)" do
    Item.transaction do
      t = Thread.new("test") { |x|
        Item.transaction do
          # empty
        end
      }
      
      lambda {t.join}.should raise_error(SQLite3::SQLException)   
    end
  end
end