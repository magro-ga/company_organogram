Rails.application.routes.draw do
  resources :companies, only: [:index, :show, :create] do
    resources :employees, only: [:index, :create]
  end

  resources :employees, only: [:show, :update, :destroy] do
    member do
      get :peers                 # 3.2 - Listar pares do colaborador
      get :direct_reports        # 3.3 - Listar liderados diretos
      get :second_level_reports  # 3.4 - Listar liderados de segundo nível
    end
  end
end
