Rails.application.routes.draw do

  mount Ckeditor::Engine => '/ckeditor'
  mount ActionCable.server => "/cable"

  root "static_pages#index"

  devise_for :user, path: "devises", controllers: {
    passwords: "devises/passwords",
    registrations: "devises/registrations",
    sessions: "devises/sessions",
  }, skip: [:sessions, :registrations]
  as :user do
    get "login", to: "devises/sessions#new", as: :new_user_session
    post "login", to: "devises/sessions#create", as: :user_session
    get "signup", to: "devises/registrations#new", as: :new_user_registration
    post "signup", to: "devises/registrations#create", as: :user_registration
    put "/signup", to: "devises/users#update"
    get "edit", to: "devises/users#edit", as: :edit_user_registration
    delete "logout", to: "devises/sessions#destroy", as: :destroy_user_session
  end

  resources :set_language, only: :index
  resources :statistic_results, only: :index

  resources :users, except: %i(destroy new create index)
  resources :registers
  resources :results
  resources :majors
  resources :notes, only: :index
  resources :file_remarkings, except: %i(edit update destroy) do
    resource :downloads, only: :show
  end
  resources :remarkings, only: %i(show new create)

  namespace :teachers do
    resources :users, except: %i(new create destroy)
    resources :majors
    resources :file_remarkings, except: %i(destroy new create)
  end

  namespace :admins do
    resources :users do
      collection { post :import_students }
    end
    resources :schools
    resources :results do
      collection { post :import_results }
    end
  end
end
