class RewardMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.reward_mailer.confirmation.subject
  #
  default from: 'rewards@fundeat.club'

  def confirmation
    @user = params[:user] # Instance variable => available in view
    mail(to: @user.email, subject: 'Your reward voucher')
  end
end
