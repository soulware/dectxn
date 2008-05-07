require File.dirname(__FILE__) + '/../spec_helper'

describe MandatoryItem do
  before(:each) do
    @mandatory_item = MandatoryItem.new
  end

  it "should be valid" do
    @mandatory_item.should be_valid
  end
end
