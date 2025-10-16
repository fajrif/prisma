Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  #get "up" => "rails/health#show", as: :rails_health_check

  devise_for :admins, :controllers => { :sessions => "admins/sessions" }

	scope "(:locale)", locale: /id/ do
		namespace :admins do
			root :to => 'dashboard#index'
			get "account/change_password" => "accounts#change_password", :as => :change_password
			put "account/update_password" => "accounts#update_password", :as => :update_password

			resources :admins

			get "link_buttons/objectable_types" => "link_buttons#objectable_types", :as => :link_button_objectable_types

			resources :menus
			resources :addresses do
				collection do
					patch :sort
				end
			end
			resources :clients
			resources :testimonials
			resources :careers do
				member do
					delete "delete_attachment/:asset_id" => "careers#delete_attachment", :as => :delete_attachment
				end
			end
			resources :banner_sections
			resources :banners do
				resources :link_buttons, :controller => "banners/link_buttons", :except => [:index, :show]
			end
			resources :articles do
				member do
					delete "delete_attachment/:asset_id" => "articles#delete_attachment", :as => :delete_attachment
					delete "delete_attachment_image/:asset_id" => "articles#delete_attachment_image", :as => :delete_attachment_image
				end
			end
			resources :categories
			resources :portfolios
			resources :awards
			resources :services do
				resources :segments, :controller => "services/segments", :except => [:index] do
					collection do
						patch :sort
					end
				end
        resources :benefits, :controller => "services/benefits", :except => [:index]
      end
			resources :industries
			resources :inquiries, :only => [:index, :show, :destroy]
			resources :pages do
				resources :sections, :controller => "pages/sections", :except => [:index] do
					collection do
						patch :sort
					end
				end
				resources :banners, :controller => "pages/banners", :only => [:destroy] do
					collection do
						patch :sort
					end
				end
			end
			resources :snippets do
				resources :link_buttons, :controller => "snippets/link_buttons", :except => [:index, :show]
				member do
					delete "delete_attachment/:asset_id" => "snippets#delete_attachment", :as => :delete_attachment
				end
			end
		end

		# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
		# i18n Scope for id

		resources :inquiries, :only => [:create]
		resources :articles, :only => [:index, :show]
		resources :services, :only => [:index, :show]
		resources :industries, :only => [:index, :show]
		resources :portfolios, :only => [:index, :show]
		resources :careers, :only => [:index, :show]
		resources :locations, :only => [:index, :show]

		# route to pages
		match "contact-us", :to => 'inquiries#show', via: :get, as: :contact_us
		match ":id", :to => 'pages#show', via: :get, as: :page
		match "/404", to: "errors#show", code: 404, via: :all
		match "/500", to: "errors#show", code: 500, via: :all
		root :to => "pages#show", id: 'home'
  end
end
