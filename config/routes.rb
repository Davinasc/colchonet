Rails.application.routes.draw do
	LOCALES = /en|pt\-BR/

	match '/:locale' => 'welcome#index', locale: LOCALES, via: [:get, :post]
  root 'welcome#index'

  scope (":locale"), locale: LOCALES  do
		resources :rooms
		resources :users
		resource :user_confirmation, :only => [:show]
	end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
