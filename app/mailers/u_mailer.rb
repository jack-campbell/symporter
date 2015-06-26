class UMailer < ActionMailer::Base
  default from: "from@example.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.u_mailer.account_activation.subject
  #
  def account_activation(u)
    @greeting = "Hi"
    @u=u
    mail to: u.email, subject: "Account activation"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.u_mailer.password_reset.subject
  #
  def password_reset
    @greeting = "Hi"
    @u = u
    mail to: u.email, subject: "Password reset"
  end
end
