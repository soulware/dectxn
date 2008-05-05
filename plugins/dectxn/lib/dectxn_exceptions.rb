module Txn
  class DecTxnException < Exception
  end
  
  class RequiresNewException < DecTxnException
  end
end
