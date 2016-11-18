Rails.application.routes.draw do
  resources :universidades, only: [:index, :show, :create, :update, :destroy]
  resources :unidades, only: [:index, :show, :create, :update, :destroy]
  resources :cursos, only: [:index, :show, :create, :update, :destroy]
  resources :turmas, only: [:index, :show, :create, :update, :destroy]
  resources :disciplinas, only: [:index, :show, :create, :update, :destroy]
  resources :eventos, only: [:index, :show, :create, :update, :destroy]
  resources :tokens, only: [:create] do
    get :send_test_notification, on: :collection
  end
  mount_devise_token_auth_for 'User', at: '/auth', controllers: {
    registrations: 'registrations'
  }
end
