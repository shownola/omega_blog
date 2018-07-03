Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  root 'pages#home'
  
  get 'pages/home', as: 'home'
  get 'pages/about', to: 'pages#about', as: 'about'
  
  resources :articles
end
