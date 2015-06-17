Rails.application.routes.draw do

	root               'pages#home'

	get 'about'     => 'pages#about'
	get 'contact'   => 'pages#contact'

	get    'login'     => 'sessions#new'
	post   'login'     => 'sessions#create'
	delete 'logout'    => 'sessions#destroy'

	resources :users
	resources :albums, 	only:  [:show, :create, :destroy] do
		resources :works, 	only:  [:create]
	end	
	resources :works, only: [:destroy]

end
