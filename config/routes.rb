Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources 'types', 'products', 'users'

  match 'search_type',to: 'types#search', via: :post
  match 'auth',to: 'users#auth', via: :get
  match 'signin',to: 'users#signin', via: :post
  match 'signout',to: 'users#signout', via: :get
  match 'search_product',to: 'products#search', via: :post

  match 'export_product',to: 'products#export', via: :post

  match 'exportjson_product',to: 'products#exportjson', via: :post

end
