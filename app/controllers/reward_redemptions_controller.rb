class RewardRedemptionsController < ApplicationController
  def create
    @investment = Investment.find(params[:investment_id])
    authorize @investment
    @investment.update(reward_redeemed: true)
    redirect_to investors_myrewards_path
  end
end
