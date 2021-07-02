Rails.application.routes.default_url_options[:host] = ENV["host"]
Rails.application.routes.draw do
  ##in future
  telegram_webhook TelegramWebhooksController
  resources :jobs
  get 'approve_job/:id', to: 'jobs#approve', as: :approve
  get 'sitemap', to: 'index#sitemap', as: :sitemap

  devise_for :users, :controllers => { :omniauth_callbacks => "callbacks" }

  resources :properties
  #devise_for :users
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  ActiveAdmin.routes(self)
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'index#index'
  get 'search', to: 'index#main_search'

  get '*path', to: 'errors#error_404', via: :all

end
