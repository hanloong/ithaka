class UserMailer < ActionMailer::Base
  default from: "hello@ithaka.io"
  default bcc: "hello@ithaka.io"

  def welcome_email(user)
    @user = user
    mail(to: @user.email, subject: 'Welcome to ithaka.io')
  end
end
