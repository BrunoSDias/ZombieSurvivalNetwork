Rails.application.routes.draw do
  get 'trade', to: 'trade#get_trade'
  post 'trade', to: 'trade#set_trade'
  get 'report', to: 'survivors#report_counter'
  resources :survivors
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
