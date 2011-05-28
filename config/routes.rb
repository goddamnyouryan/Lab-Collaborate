Lab::Application.routes.draw do

  devise_for :users

  root :to => "home#index"
  
  match '/choose-university', :to => "home#choose_university", :as => "choose_school"
  
  match ':controller(/:action(/:id(.:format)))'
end
