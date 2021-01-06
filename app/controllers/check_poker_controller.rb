class CheckPokerController < ApplicationController
  def input_cards
  end

  def judge_cards
    @errors = ValidateService.validate_cards(params[:cards])
    if @errors.empty?
      @check_result = CheckService.check_cards(params[:cards])
    end
    @cards = params[:cards]
  end

end