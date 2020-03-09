class RewardRedemptionsController < ApplicationController
  def create
    @investment = Investment.find(params[:investment_id])
    @investor = User.find(@investment.investor_id)
    @owner = @investment.company.owner

    authorize @investment
    @investment.update(reward_redeemed: true)

    mail_to_investor = RewardMailer.with(user: @investor).confirmation
    mail_to_investor.deliver_now

    mail_to_owner = RewardMailer.with(user: @owner).confirmation
    mail_to_owner.deliver_now

    redirect_to investors_myrewards_path
  end
end
