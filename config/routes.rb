LinkGrabber::Application.routes.draw do
  root to: 'links#index'

  resources :links, only: [:index, :create, :update, :destroy]
end
