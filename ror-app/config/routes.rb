Rails.application.routes.draw do
  devise_for :users, skip: %i[registrations sessions passwords]
  devise_scope :user do
    post 'users/sign_up', to: 'users/registrations#create'
    post 'users/sign_in', to: 'users/sessions#create'
    delete 'userse/sign_out', to: 'users/sessions#destroy'
  end
  
end
