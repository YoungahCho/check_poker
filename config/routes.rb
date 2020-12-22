# frozen_string_literal: true
#
Rails.application.routes.draw do
  get '/' => 'check_poker#check_add'
  post '/judge_cards' => 'check_poker#judge_cards'
  end
#   # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  Rails.application.routes.draw do
    mount Poker::Check_cards => '/api'
    root 'check_poker#check_add'
    post '/judge_cards' => 'check_poker#judge_cards'
  end

