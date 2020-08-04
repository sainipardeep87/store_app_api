Rails.application.routes.draw do
  resources :products
  devise_for :users, skip: [:sessions, :passwords, :registrations, :confirmations]

    
        devise_scope :user do
          post 'users/register', to: 'users/registrations#create'
          post 'users/login', to: 'users/sessions#create'
          post 'users/social_login', to: 'users/sessions#social_login'
          delete 'users/logout', to: 'users/sessions#destroy'
          post 'users/password', to: 'users/passwords#create'
          get 'users/password/verify_token', to: 'users/passwords#edit'
          put 'users/reset_password', to: 'users/passwords#update'
          post 'users/resend_confirmation_email', to: 'users/registrations#resend_confirmation_email'
          get 'users/confirmations/confirmed', to: 'users/confirmations#confirmed'
        end
        resources :carts
   

end
