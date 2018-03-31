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
    patch "/signup", to: "devises/users#update"
    get "signup", to: "devises/registrations#new", as: :new_user_registration
    post "signup", to: "devises/registrations#create", as: :user_registration
    get "edit", to: "devises/users#edit", as: :edit_user_registration
    delete "logout", to: "devises/sessions#destroy", as: :destroy_user_session
    get "/suggestion_register", to: "registers#edit"
    patch "/change_register", to: "registers#update"
  end

  resources :set_language, only: :index
  resources :statistic_results, only: :index
  get "/statistic_result", to: "statistic_results#show"

  resources :users, except: %i(destroy new create index) do
    get "/suggestion", to: "suggestions#index", as: :suggestions
  end
  resources :registers,except: %i(destroy edit update)
  resources :results
  resources :majors
  resources :notes, only: :index
  resources :departments, only: :index
  resources :file_remarkings, except: %i(destroy) do
    resource :downloads, only: :show
  end
  resources :remarkings, only: %i(show new create)

  namespace :teachers do
    resources :users, except: %i(new create destroy)
    resources :majors
    resources :file_remarkings, except: %i(destroy new create)
    resources :targets, only: %i(index create)
  end

  namespace :admins do
    resources :users do
      collection { post :import_students }
    end
    resources :schools
    resources :results do
      collection { post :import_results }
    end
    resources :notes
    resources :style_majors
  end
  resources :favorites
end
