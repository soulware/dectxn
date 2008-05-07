class MandatoryItem < ActiveRecord::Base
  def change_price(price)
    self.price = price    
    save!    
  end
  
  def change_name(name)
    self.name = name    
    save!    
  end
  
end
