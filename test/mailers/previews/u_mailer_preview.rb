# Preview all emails at http://localhost:3000/rails/mailers/u_mailer
class UMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/u_mailer/account_activation
  def account_activation
  u = U.first
    u.activation_token = U.new_token
    UMailer.account_activation(u)
  end

  # Preview this email at http://localhost:3000/rails/mailers/u_mailer/password_reset
  def password_reset
    u = U.first
    u.reset_token = U.new_token
    UMailer.password_reset(u)
  end

end
