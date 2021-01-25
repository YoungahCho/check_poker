Rails.application.routes.draw do
  get '/' => 'check_poker#new'
  post '/' => 'check_poker#show'
 # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

  Rails.application.routes.draw do
    mount Poker::CheckCards => '/api'
  end

