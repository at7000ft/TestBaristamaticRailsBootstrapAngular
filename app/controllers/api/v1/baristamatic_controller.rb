#
# Title: BaristaController
# Description: A REST/JSON API controller returning current inventory and drink lists
#
# Author: rholl00 
# Date: 1/7/15
#

module Api
  module V1
    class BaristamaticController < ActionController::Base
      after_filter :cors_set_access_control_headers

      #Access at http://localhost:3000/api/v1/inventory
      def inventory
        puts "inventory: called with params - #{params}"
        @inventory = BaristaServiceMem.instance.getInventoryAvailable
        render json: @inventory
      end

      #Access at http://localhost:3000/api/v1/drinks
      def drinks
        puts "drinks: called"
        @drinks = BaristaServiceMem.instance.getDrinks
        render json: @drinks
      end

      def reStockInventory
        puts "reStockInventory: called"
        BaristaServiceMem.instance.reStockInventory
        render json: '{}'
      end

      def buy
        puts "buy: called for drink #{params['number']}"
        BaristaServiceMem.instance.orderDrink(params['number'])
        render json: '{}'
      end

      private

      # For all responses in this controller, return the CORS access control headers.
      # Needed for localhost testing
      def cors_set_access_control_headers
        headers['Access-Control-Allow-Origin'] = '*'
        headers['Access-Control-Allow-Methods'] = 'POST, GET, OPTIONS'
        headers['Access-Control-Allow-Headers'] = %w{Origin Accept Content-Type X-Requested-With X-CSRF-Token}.join(',')
        headers['Access-Control-Max-Age'] = "1728000"
      end


    end
  end
end