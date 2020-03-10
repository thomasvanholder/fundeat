# Preview all emails at http://localhost:3000/rails/mailers/reward_mailer
class RewardMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/reward_mailer/confirmation
  def confirmation
    RewardMailer.confirmation
  end

end
