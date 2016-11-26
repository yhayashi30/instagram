class NoticeMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notice_mailer.sendmail_post.subject
  #
  def sendmail_post(post)
    @post = post
    user = User.find(post.user_id)

    mail to: user.email,
         subject: '【Instagram】写真が投稿されました'
  end
end
