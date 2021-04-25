Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html


  get '/merchant/:merchant_id/discounts/new', to: 'discounts#new'
  get '/merchant/:merchant_id/discounts', to: 'discounts#index'
  post "/merchant/:merchant_id/discounts", to: 'discounts#create'

  get '/merchant/:merchant_id/discounts/:discount_id', to: 'discounts#show'
  delete "/merchant/:merchant_id/discounts/:discount_id", to: 'discounts#destroy'

  get "/merchant/:merchant_id/discounts/:discount_id/edit", to: "discounts#edit"
  patch "/merchant/:merchant_id/discounts/:discount_id", to: "discounts#update"

  resources :merchant, only: [:show] do
    resources :dashboard, only: [:index]
    resources :items, except: [:destroy]
    resources :item_status, only: [:update]
    resources :invoices, only: [:index, :show, :update]
  end

  namespace :admin do
    resources :dashboard, only: [:index]
    resources :merchants, except: [:destroy]
    resources :merchant_status, only: [:update]
    resources :invoices, except: [:new, :destroy]
  end

end
