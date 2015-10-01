class UserMailer < ActionMailer::Base

  def new_comment_email comment
    @comment = comment
    mail(to: "sergi.villanueva@gmail.com;wislabe@gmail.com", subject: "Footballia - New comment", from: "Footballia.net <info@footballia.net>") do |format|
      format.html { render layout: 'email' }
    end
  end

  def new_comment_reply_email comment
    @comment = comment.parent
    mail(to: @comment.user.email, subject: "Footballia - New comment", from: "Footballia.net <info@footballia.net>") do |format|
      format.html { render layout: 'email' }
    end
  end
end
