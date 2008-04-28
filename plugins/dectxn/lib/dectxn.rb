require 'aquarium'

#
# required:: Begins new or joins existing transaction.
# requires_new:: [not yet implemented]
# mandatory:: [not yet implemented]
#
# The method selector can be specified as a regular expression, a symbol, a string or a list of symbols or strings.
#
#   Txn::required :for_type => Account, :calls_to => /^debit/ 
#   Txn::required :for_type => Account, :calls_to => :debit
#   Txn::required :for_type => Account, :calls_to => "debit"
#   Txn::required :for_type => Account, :calls_to => [:debit, :credit]
#   Txn::required :for_type => Account, :calls_to => ["debit", "credit"]
#
#
# * NotSupported
# * Supports
# * Never
#
module Txn
  include Aquarium::Aspects
  
  @@log = RAILS_DEFAULT_LOGGER
  

  


  
  
  #
  # Txn::required will join an existing transaction if called from within a transaction.
  # Otherwise it will automatically begin a new transaction and will commit the transaction
  # if the method commits successfully. Any uncaught exception will rollback the transaction.
  #
  # == Example
  # Txn::required :for_type => :Account, :calls_to => :debit
  #
  def self.required(hash)
    Aspect.new :around, hash do |join_point, obj, *args|  
      wrap_in_transaction(join_point)
    end
  end 
  
  private
  
  def self.wrap_in_transaction(join_point)
    @@log.debug "enter: #{join_point.target_type.name}##{join_point.method_name}"
  
    open_transactions = Thread.current['open_transactions']
  
    if(open_transactions.nil? or open_transactions == 0)
      ActiveRecord::Base.transaction do 
        @@log.debug "begin txn "
        result = join_point.proceed
        @@log.debug "commit txn"
        result
      end
    else
      @@log.debug "joining existing txn (depth #{open_transactions})"
      join_point.proceed
    end
  end
end
