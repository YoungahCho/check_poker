class CheckPokerController < ApplicationController
  def check_add
  end

  def judge_cards
    @errors = ValidateService.validate_cards(params[:cards])
    if @errors.empty?
      @check_result = CheckService.check_cards(params[:cards])

    end

    @cards = params[:cards]
  end
end