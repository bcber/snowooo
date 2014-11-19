class UserMailer < ActionMailer::Base
  default from: "admin@snowooo.com"

  def welcome_mail(id)
    @user = User.find(id)
    @url = "#{ENV['domain']}/login"
    mail(from: '雪圈网',to: @user.email, subject: '欢迎来到雪圈网！')
  end
end
