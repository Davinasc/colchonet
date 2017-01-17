Rails.application.routes.draw do

  root 'welcome#index'

	resources :rooms
	resources :users
	resource :confirmation, :only => [:show]
	resource :user_sessions, :only => [:create, :new, :destroy]

end
