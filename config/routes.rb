Lab::Application.routes.draw do

  get "whiteboards/create"

  get "protocols/create"

  devise_for :users
  
  match '/choose-university', :to => "home#choose_university", :as => "choose_school"
  match '/find-your-lab', :to => 'home#find_lab', :as => "find_lab"
  match '/add_affiliate', :to => 'laboratories#add_affiliate'
  match '/accept_affiliate', :to => 'laboratories#accept_affiliate'
  match '/decline_affiliate', :to => 'laboratories#decline_affiliate'
  match '/add_friend', :to => 'laboratories#add_friend'
  match '/accept_friend', :to => 'laboratories#accept_friend'
  match '/decline_friend', :to => 'laboratories#decline_friend'
  
  resources :schools do
    get :autocomplete_school_name, :on => :collection
  end
  
  resources :users, :only => ["show"]
  resources :laboratories
  resources :protocols
  resources :whiteboards
  
  root :to => "home#index"
  
  match ':controller(/:action(/:id(.:format)))'
  
end
