#
# dectxn exception classes -
#
# * Txn::DecTxnException
# * Txn::RequiresNewException
#
module Txn
  
  #
  # Base exception for dectxn.
  #
  class DecTxnException < Exception
  end
  
  #
  # Thrown in Txn::requires_new if attempt 
  # is made to start a new transaction
  # within an existing active transaction.
  #
  class RequiresNewException < DecTxnException
  end
  
  #
  # Thrown in Txn::mandatory if attempt 
  # is made to start a new transaction 
  # within an existing active transaction.
  #
  class MandatoryException < DecTxnException
  end
end
