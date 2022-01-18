Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :users, only: [:create]
      post 'auth/login', to: 'auth#login'
      post 'auth/refresh', to: 'auth#refresh'
      get 'user/profile', to: 'users#profile'
    end
  end
  scope(:path => '/api') do
    resources :category, :product, :review
    get 'review/all/:item_id', to: 'review#index'
    get 'product/all/:products_count', to: 'product#index'
    get 'product/products_by_category/:category_id/:products_count', to: 'product#products_by_category'
    get '/*admin.php', to: redirect('https://www.youtube.com/watch?v=dPWkNS5AMVM')
  end
end
