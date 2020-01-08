class UserMailer < ApplicationMailer
  default from: 'Sam Ruby <depot@example.com>'
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.created.subject
  #
  def welcome_email(user)
    @user = user

    mail to: @user.email, subject: 'Welcome'
  end

  def consolidated_orders_mail(user)
    @user = user
    mail to: @user.email, subject: 'All Orders till date'
  end
end
