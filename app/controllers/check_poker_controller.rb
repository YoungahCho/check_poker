require 'application_controller'

class CheckPokerController < ApplicationController

  def new; end

  def show
    @cards = params[:cards]
    @errors = ValidateService.validate_cards(params[:cards])
    if @errors.present?
      render 'new'
    else
      @check_result = CheckService.check_cards(params[:cards])
    end
  end
end
