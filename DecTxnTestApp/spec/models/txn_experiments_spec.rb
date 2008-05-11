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
end