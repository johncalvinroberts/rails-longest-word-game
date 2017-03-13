Rails.application.routes.draw do
  get '/guess', to: "game#guess"

  get '/result', to: "game#result"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
