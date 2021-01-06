Rails.application.routes.draw do
  get '/' => 'check_poker#input_cards'
  post '/' => 'check_poker#judge_cards'
 # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

  Rails.application.routes.draw do
    mount Poker::CheckCards => '/api'
  end

