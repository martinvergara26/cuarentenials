Rails.application.routes.draw do
  resources :interactions
  resources :timeslots
  resources :gifts
  post 'create_custom_gift', to: 'gifts#create_custom_gift'
  post 'create_custom_interaction', to: 'interactions#create_custom_interaction'
  resources :phases
  resources :births
  get 'my_births', to: 'births#my_births'

  resources :given_gifts

  devise_for :users, skip: %i[registrations sessions passwords]
  devise_scope :user do
    post 'users/sign_up', to: 'users/registrations#create'
    post 'users/sign_in', to: 'users/sessions#create'
    delete 'userse/sign_out', to: 'users/sessions#destroy'
  end
  
end
