#
# Title: DrinkMem
# Description: 
#
# Author: rholl00 
# Date: 12/31/14
#

class DrinkMem
  attr_accessor :number, :name, :displayName, :recipe, :cost, :inStock

  def initialize(number, name, displayName, recipe)
    @number = number
    @name = name
    @displayName = displayName
    @recipe = recipe
  end

  def to_s
    "number: #{@number} name: #{@name} "
  end


end