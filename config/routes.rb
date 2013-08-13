IphoneUrlSchemeChecker::Application.routes.draw do
  root 'welcome#index'

  resources :uploads, only: [] do
    post :device_record, on: :collection
  end
end
