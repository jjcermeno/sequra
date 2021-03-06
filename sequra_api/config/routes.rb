Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

  get "show_404", controller: :routing_errors, action: :show_404

  match '*path', to: 'routing_errors#show_404', via: :all
end
