Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get ':language/words', to: redirect('/:language'), as: 'words'
  post ':language/words', to: 'words#index'
  get ':language', to: 'home#index', as: 'root'

  root 'home#index'
end
