Rails.application.routes.draw do
  resources :books
  #get "home/index"
  get 'home/about', to: 'home#about'
  get 'home/book', to: 'home#books'
  get 'home/header', to: 'pages#header'
  root 'home#index'
  resources :books do
  member do
    post 'borrow'
    post 'return_book'
  end
end
end


