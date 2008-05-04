
# all change_xxx methods on Item class etc.
Txn::required :for_types => Item, :calls_to => /^change_/
Txn::required :for_types => Item, :calls_to => /^increase_/
Txn::required :for_types => Item, :calls_to => /^update_/, :method_options => :class
Txn::required :for_types => Item, :calls_to => /^find_twice_/, :method_options => :class

# work in progress
Txn::requires_new :for_types => RequiresNewItem, :calls_to => /^change_/



