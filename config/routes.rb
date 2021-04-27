Rails.application.routes.draw do
	namespace :api do
		namespace :v1 do
		resources :users
				resources :recipes do
					resources :reviews
				end
			post "login", to: "users#login"
		end
	end


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
