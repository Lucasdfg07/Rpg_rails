Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  post 'welcome/index'
  post 'welcome/moeda'

  get 'welcome/monstro'
  get 'welcome/morte'
  get 'welcome/moeda'
  get 'welcome/index'

  get 'user/index'
  post 'user/create'

  root 'user#index'
end
