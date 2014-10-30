class MailWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(email,token)
    confirm_email_html = <<-HTML
      <h1>欢迎来到雪圈网</h1>
      <h2><a href='http://#{ENV['domain']}/users/confirmation?confirmation_token=#{token}'>激活我在雪圈网的帐号</a></h2><br>\
      
      <h3>如果上述链接失效请复制下面的连接到你的浏览器：</h3><br>
      
      http://#{ENV['domain']}/users/confirmation?confirmation_token=#{token}
    HTML
    
    confirm_email_text = <<-TEXT
      http://#{ENV['domain']}/users/confirmation?confirmation_token=#{token}
    TEXT

    data = Hash.new
    data[:from] = "snowoooo <me@#{ENV['mail_domain']}>"
    data[:to] = email
    data[:subject] = "welcome to snowooo"
    data[:text] = confirm_email_text
    data[:html] = confirm_email_html

    RestClient.post("https://api:key-4d6c4032665e5a0b11445847b0892074@api.mailgun.net/v2/snowooo.nxbtch.com/messages", data)
  end
end