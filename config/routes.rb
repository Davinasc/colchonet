Rails.application.routes.draw do

  root 'welcome#index'

	resources :rooms
	resources :users
	resource :confirmation, :only => [:show]

end
