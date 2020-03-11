class SupportMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.reward_mailer.confirmation.subject
  #
  default from: 'support@fundeat.club'

  def appointment(name:, owner:, email:, message:, date:)
    # @user = user # Instance variable => available in view
    @name = name
    @owner = owner
    @email = email
    @message = message
    @date = date
    mail(to: 'support@fundeat.club', subject: 'Appointment scheduled')
  end
end
