# frozen_string_literal: true

Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'

  namespace :api do
    namespace :v1 do
      resources :responses
      resources :feedbacks
      resources :options
      resources :questions
      resources :surveys
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
