Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get 'coordinates', to: 'coordinates#fetch'
    end
  end
end
