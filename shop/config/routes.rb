Rails.application.routes.draw do
  scope(:path => '/api') do
    resources :category, :item, :review
    get 'review/all/:item_id', to: 'review#index'
    get 'item/all/:items_count', to: 'item#index'
    get 'item/items_by_category/:category_id/:items_count', to: 'item#items_by_category'
    get '/*admin.php', to: redirect('https://www.youtube.com/watch?v=dPWkNS5AMVM')
  end
end
