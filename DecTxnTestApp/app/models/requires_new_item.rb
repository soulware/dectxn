class RequiresNewItem < ActiveRecord::Base
  def change_price(price)
    self.price = price    
    save!    
  end
  
  def change_name(name)
    self.name = name    
    save!    
  end
  
  # note - nested method calls here should raise an exception (for Txn::requires_new)
  # as we cannot start a new transaction within an existing transaction
  def change_name_and_price(name, price)
    change_name(name)
    change_price(price)
  end
  
  def change_name_and_price_single_txn(name, price)
    self.price = price
    save!
    
    self.name = name
    save!
  end
end
