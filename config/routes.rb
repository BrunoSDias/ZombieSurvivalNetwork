Rails.application.routes.draw do
  get 'trade', to: 'trade#get_trade'
  post 'trade', to: 'trade#set_trade'
  resources :survivors
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
