#
# Title: InventoryEntryMem
# Description: 
#
# Author: rholl00 
# Date: 12/31/14
#

class InventoryEntryMem
  attr_accessor :displayName, :name, :cost, :count

  def initialize(displayName,name,cost,count)
    @displayName = displayName
    @name = name
    @cost = cost
    @count = count
  end

  def consumeIngredient(decrCount)
    @count > decrCount ? @count -= decrCount : @count =0

  end

end