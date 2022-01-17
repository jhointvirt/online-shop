class ApplicationController < ActionController::API
  include Pagy::Backend
  Pagy::DEFAULT[:items] = 25
end
