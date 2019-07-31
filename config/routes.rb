Rails.application.routes.draw do
  get 'trade', to: 'trade#get_trade'
  post 'trade', to: 'trade#set_trade'
  get 'report', to: 'survivors#report_counter'
  get 'survivors_info', to: 'survivors#survivors_info'
  resources :survivors, except: [:destroy]
end
