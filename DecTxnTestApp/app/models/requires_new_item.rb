class RequiresNewItem < ActiveRecord::Base
  def change_price(price)
    self.price = price    
    save!
    
    throw Exception.new("requires_new is not currently implemented")
  end
end
