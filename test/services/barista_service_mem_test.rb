#
# Title: BaristaServiceMemTest
# Description: 
#
# Author: rholl00 
# Date: 12/31/14
#


require 'test_helper'

class BaristaServiceMemTest < ActiveSupport::TestCase

  def test_construction
    # Test the singleton module
    serviceMem = BaristaServiceMem.instance
    serviceMem2 = BaristaServiceMem.instance
    assert_equal(serviceMem,serviceMem2)

    drink = serviceMem.getDrink('1')
    p drink
    assert_equal(drink.name, 'coffee')

    inv = serviceMem.getInventoryAvailable
    assert_equal(inv.size, 9)

    serviceMem.reStockInventory
    inv = serviceMem.getInventoryAvailable
    inv.each {|invItem| assert_equal(invItem.count, 10)}

    #
    serviceMem.orderDrink('1')
    inv = serviceMem.getInventoryAvailable.select {|inv_item| inv_item.name == 'coffee'}[0]
    assert_equal(inv.count, 7)

    #
    cost = serviceMem.getDrinkCost('caffeAmericano')
    assert_equal(cost, 3.30)

    #
    assert serviceMem.areIngredientsAvailable('1')
    serviceMem.orderDrink('1')
    serviceMem.orderDrink('1')
    assert !serviceMem.areIngredientsAvailable('1')

    #
    drinks = serviceMem.getDrinks
    assert_equal(drinks.size, 6)
    assert_equal(false, drinks.select {|drnk| drnk.number == 1}[0].inStock)
    assert_equal(true, drinks.select {|drnk| drnk.number == 2}[0].inStock)
    assert_equal(true, drinks.select {|drnk| drnk.number == 3}[0].inStock)
    assert_equal(true, drinks.select {|drnk| drnk.number == 4}[0].inStock)
    assert_equal(true, drinks.select {|drnk| drnk.number == 5}[0].inStock)
    assert_equal(true, drinks.select {|drnk| drnk.number == 6}[0].inStock)
    serviceMem.reStockInventory
    drinks = serviceMem.getDrinks
    assert_equal(true, drinks.select {|drnk| drnk.number == 1}[0].inStock)

  end

  def test_drink
    drink = DrinkMem.new(1, 'coffee', 'Coffee', {'coffee' => 3, 'sugar' => 1, 'cream' => 1})
    p drink
    assert_equal(drink.name, 'coffee')
  end

end