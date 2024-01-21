class UserMailer < ApplicationMailer
  default from: User::MAILER_FROM_EMAIL

  def confirmation(user, confirmation_token)
    @user = user
    @confirmation_token = confirmation_token


    puts "\n\n\n\nConfirmation Instructions \
#{edit_confirmation_url(@confirmation_token)}\n\n\n\n"

    mail to: @user.confirmable_email, subject: "Confirmation Instructions"
  end

  def password_reset(user, password_reset_token)
    @user = user
    @password_reset_token = password_reset_token

    puts "\n\n\n\nPassword Reset Instructions \
#{edit_password_url(@password_reset_token)}\n\n\n\n"

    mail to: @user.email, subject: "Password Reset Instructions"
  end
end
