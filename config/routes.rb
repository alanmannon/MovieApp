Rails.application.routes.draw do
  namespace :api do
    get "/search" => "searches#index"
    get "/search:id" => "searches#show"

    get "/movies" => "movies#index"
    post "/movies" => "movies#create"
    patch "/movies/:id" => "movies#update"
  end
end
