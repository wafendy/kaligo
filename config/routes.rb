Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  scope :v1 do
    resources :hotels, only: [:index]
    resources :suppliers, only: [:index]
  end
end
