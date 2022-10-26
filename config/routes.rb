Rails.application.routes.draw do
  # NEED minimum a route, a controller with an action, and a view.
  #keyword root sets the homepage
  root "articles#index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # GET /articles requests are mapped to the index action of ArticlesController.
  # Defines the root path route ("/")
  # replaced the get with resources:
    # get "/articles", to: "articles#index"
    # get "/articles/:id", to: "articles#show"
  resources :articles do
    resources :comments
  end
end
