Rails.application.routes.draw do
  # You can have the root of your site routed with "root"
  root 'baristamatic#index'

  #
  # For Angular pages
  get 'baristamatic' => 'baristamatic#index'
  get 'baristamatic/*page', to: 'baristamatic#index'

  #
  # Routes for angular to rest/json api
  namespace :api do
    namespace :v1 do
      get 'inventory' => 'baristamatic#inventory'
      get 'drinks' => 'baristamatic#drinks'
      get 'reStockInventory' => 'baristamatic#reStockInventory'
      get 'buy' => 'baristamatic#buy'

    end
  end
end
