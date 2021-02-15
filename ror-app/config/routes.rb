Rails.application.routes.draw do
  resources :timeslots
  resources :gifts
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
