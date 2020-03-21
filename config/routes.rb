Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resource :users, only: [:create, :update, :destroy]
    end
  end
end
