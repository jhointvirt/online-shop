Rails.application.routes.draw do
  scope(:path => '/api') do
    resources :category, :item
    get '/*admin.php', to: redirect('https://www.youtube.com/watch?v=dPWkNS5AMVM')
  end
end
