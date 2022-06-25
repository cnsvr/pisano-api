Rails.application.routes.draw do
  resources :responses
  resources :feedbacks
  resources :options
  resources :questions
  resources :surveys
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
