#
# Title: BaristaService
# Description: In memory inventory and drink state service.
#
# Author: rholl00 
# Date: 12/30/14
#

class BaristaServiceMem
  # Inclulding this module makes this class a singleton, get the instance using BaristaServiceMem.instance
  include Singleton

  def initialize
    @drinks = [
        DrinkMem.new(1, 'coffee', 'Coffee', {'coffee' => 3, 'sugar' => 1, 'cream' => 1}),
        DrinkMem.new(2, 'decafCoffee', 'Decaf Coffee', {'decafCoffee'=> 3, 'sugar' => 1, 'cream'=> 1}),
        DrinkMem.new(3, 'caffeLatte', 'Caffe Latte', {'espresso'=> 2, 'steamedMilk'=>1}),
        DrinkMem.new(4, 'caffeAmericano', 'Caffe Americano', {'espresso'=> 3}),
        DrinkMem.new(5, 'caffeMocha', 'Caffe Mocha', {'espresso'=> 1, 'cocoa' => 1, 'steamedMilk'=> 1, 'whippedCream'=>1}),
        DrinkMem.new(6, 'cappuccino', 'Cappuccino', {'espresso'=> 2, 'steamedMilk'=> 1, 'foamedMilk'=> 1})
    ]

    @inventory = {
        'cocoa' => InventoryEntryMem.new('Cocoa','cocoa',0.90,10),
        'coffee' => InventoryEntryMem.new('Coffee','coffee',0.75,10),
        'decafCoffee' => InventoryEntryMem.new('Decaf Coffee','decafCoffee',0.75,10),
        'sugar' => InventoryEntryMem.new('Sugar','sugar',0.25,10),
        'cream' => InventoryEntryMem.new('Cream','cream',0.25,10),
        'steamedMilk' => InventoryEntryMem.new('Steamed Milk','steamedMilk',0.35,10),
        'foamedMilk' => InventoryEntryMem.new('Foamed Milk','foamedMilk',0.35,10),
        'espresso' => InventoryEntryMem.new('Espresso','espresso',1.10,10),
        'whippedCream' => InventoryEntryMem.new('Whipped Cream','whippedCream',1.00,10)
    }

    #Calc drink cost
    @drinks.each do |drink|
      drink.cost = getDrinkCost(drink.name)
    end

  end

  #Update inStock for each drink and return list
  def getDrinks
    @drinks.each do |drink|
      drink.inStock = areIngredientsAvailable(drink.number)
    end
    @drinks
  end

  def getInventoryAvailable
    @inventory.values.sort_by {|inv| inv.displayName}
  end

  def orderDrink(drinkNumber)
    recipe = getDrink(drinkNumber).recipe
    recipe.each do |key, value|
      @inventory[key].consumeIngredient(value)
    end

  end

  def reStockInventory
    @inventory.values.each { |inv| inv.count = 10}
  end

  private

  def getDrinkCost(name)
    recipe = @drinks.select {|drink| drink.name == name}[0].recipe
    cost = 0.0
    recipe.each do |ingredient, count|
      cost += @inventory[ingredient].cost * count
    end
    cost.round(2)
  end

  def areIngredientsAvailable(drinkNumber)
    recipe = @drinks.select {|drink| drink.number == drinkNumber.to_i}[0].recipe
    recipe.each do |ingredient, count|
      avail = @inventory[ingredient].count
      if count > avail
        return false
      end
    end
    true
  end

  def getDrink(drinkNumber)
    @drinks.select {|drink| drink.number == drinkNumber.to_i}[0]
  end
end