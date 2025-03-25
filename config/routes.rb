Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Static HTML routes that bypass middleware issues - HIGHEST PRIORITY
  get 'static', to: 'static#index'
  get 'static/game', to: 'static#game'
  
  # Direct static file URLs - SECOND HIGHEST PRIORITY
  get 'static.html', to: redirect('/static')
  get 'game.html', to: redirect('/static/game')
  get 'standalone.html', to: redirect('/standalone')

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # API routes
  namespace :api do
    resources :cards, only: [:index, :show, :create, :update, :destroy]
    
    # Status endpoint for diagnostics
    get 'status', to: 'status#index'
    
    # Game API endpoints
    post 'game/start', to: 'game#start'
    post 'game/move', to: 'game#move'
  end

  # Game UI route
  get 'game', to: 'game#index'
  
  # Standalone game route
  get 'standalone', to: 'html_game#standalone'
  
  # Home route for React SPA
  root "home#index"
  
  # Catch all routes for React Router - EXCEPT for the /game and /static paths
  get '*path', to: 'home#index', 
      constraints: lambda { |req| 
        !req.xhr? && 
        req.format.html? && 
        !req.path.start_with?('/game') && 
        !req.path.start_with?('/static') && 
        !req.path.start_with?('/api')
      }

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
end
