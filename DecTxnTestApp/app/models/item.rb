class Item < ActiveRecord::Base
  def change_price(price)
    self.price = price    
    save!
  end
  
  def change_name(name)
    self.name = name
    save!
  end
  
  # note - no transaction specified here
  # the two save! methods would normally create two independent transactions
  def change_name_and_price(name, price)
    change_name(name)
    change_price(price)
  end
  
  def change_price_then_rollback(price)
    change_price(price)
    raise ActiveRecord::Rollback
  end
  
  def change_name_and_price_then_rollback(name, price)
    change_name(name)
    change_price_then_rollback(price)
  end
  
  def change_name_and_price_then_rollback_outer(name, price)
    change_name(name)
    change_price(price)
    raise ActiveRecord::Rollback
  end
  
  def increase_price_twice_with_intermediate_reload(price1, price2)
    change_price(self.price + price1)
    self.reload
    change_price(self.price + price2)
  end
  
  def self.find_twice_update_first_name(name, new_name)
    item1 = find_by_name(name)
    item1.change_name(new_name)
    
    # this will actually find within an uncommitted transaction
    item2 = find_by_name(new_name)
    [item1, item2]
  end
  
  def self.update_name_thru_classmethod(item, name)
    item.name = name
    item.save!
  end
  
  def self.update_name_thru_classmethod_nested(item, name)
    item.change_name(name)
  end
end
