Rails.application.routes.draw do
  root "users#index"
  devise_for :users
  resources :users, :only => [:index, :show, :new]
  resources :messages, :only => [:create]
  resources :rooms, :only => [:create, :show, :index]
  resources :blogs, :only => [:create, :show, :new, :destroy, :update, :edit]
  get "blogs/:id" => "blogs#show"
end
