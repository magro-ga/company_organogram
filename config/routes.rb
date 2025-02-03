Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :companies, only: [:index, :show, :create] do
        resources :employees, only: [:index, :create, :show, :destroy] do
          member do
            get :peers
            get :direct_reports
            get :second_level_reports
          end
        end
      end
    end

    namespace :v2 do
      post "/graphql", to: "graphql#execute"
    end
  end

  if Rails.env.development?
    mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/api/v2/graphql"
  end
end
