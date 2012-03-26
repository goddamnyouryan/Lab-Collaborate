Lab::Application.routes.draw do

  get "follows/create"

  get "follows/destroy"

  devise_for :users, :controllers => { :registrations => 'users/registrations' }
  
  match '/choose-university', :to => "home#choose_university", :as => "choose_school"
  match '/find-your-lab', :to => 'home#find_lab', :as => "find_lab"
  match '/add_affiliate', :to => 'laboratories#add_affiliate'
  match '/accept_affiliate', :to => 'laboratories#accept_affiliate'
  match '/decline_affiliate', :to => 'laboratories#decline_affiliate'
  match '/remove_affiliate', :to => 'laboratories#remove_affiliate'
  match '/add_friend', :to => 'laboratories#add_friend'
  match '/accept_friend', :to => 'laboratories#accept_friend'
  match '/decline_friend', :to => 'laboratories#decline_friend'
  match '/remove_friend', :to => 'laboratories#remove_friend'
  match '/send-invites', :to => 'laboratories#send_invites'
  match '/make-admin', :to => 'users#make_admin', :as => "make_admin"
  match '/mark_as_ordered', :to => 'inventories#mark_as_ordered'
  match '/search', :to => 'home#search'
  match '/update-school', :to => 'home#update_school'
  match '/reply', :to => 'whiteboards#reply'
  match '/create_reply', :to => 'whiteboards#create_reply'
  
  resources :schools
  resources :follows, :only => [ :create, :destroy ]
  resources :users do
    match "message"
    match "send_message"
    match "message_sent"
  end
  resources :laboratories do
    resources :inventories
    get 'library'
    get 'protocols'
    get 'papers'
    get 'presentations'
    get 'data'
    get 'pictures'
    get 'members'
    get 'invite'
    get 'edit_info'
    get 'activity_stream'
    match 'results_of_the_week', :to => 'protocols#results_of_the_week'
    match 'upload_results', :to => 'protocols#upload_results'
  end
  resources :protocols do
    resources :likes, :only => [:create, :destroy]
  end
  resources :whiteboards
  resources :rsses
  match 'rss', :to => 'rsses#index'
  
  root :to => "home#index"
  
  match ':controller(/:action(/:id(.:format)))'
  
end
