Rails.application.routes.draw do
  scope(:path => '/api') do
    resources :category, :item
    get 'item/items_by_category/:category_id', to: 'item#items_by_category'
    get '/*admin.php', to: redirect('https://www.youtube.com/watch?v=dPWkNS5AMVM')
  end
end
