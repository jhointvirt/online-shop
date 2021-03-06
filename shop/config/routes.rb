require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'
  namespace :api do
    namespace :v1 do
      resources :users, only: [:create]
      resources :category, :product, :review, :coupon
      post 'auth/login', to: 'auth#login'
      post 'auth/refresh', to: 'auth#refresh'
      post 'basket', to: 'basket#add_to_basket'

      get 'user/profile', to: 'users#profile'
      get 'review/all/:product_id', to: 'review#index'
      get 'product/all/:products_count', to: 'product#index'
      get 'product/products_by_category/:category_id/:products_count', to: 'product#products_by_category'
      get 'basket/count', to: 'basket#basket_count'
      get 'basket', to: 'basket#show'

      put 'coupon/used/add_used', to: 'coupon#add_used'

      delete 'basket', to: 'basket#remove_from_basket'
    end
  end
  get '/*admin.php', to: redirect('https://www.youtube.com/watch?v=dPWkNS5AMVM')
end
