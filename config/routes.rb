Rails.application.routes.draw do

  root 'welcome#index'

	resources :rooms do 
		resources :reviews, :only => [:create, :update], controller: 'rooms/reviews'
	end
	resources :users
	resource :confirmation, :only => [:show]
	resource :user_sessions, :only => [:create, :new, :destroy]

end
