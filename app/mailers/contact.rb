class Contact < ActionMailer::Base
  default :from => "photocaching@ars-subtilior.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.contact.contact.subject
  #
  def contact(sender_email, sender_name, subject, type, body)
    @subject_text = subject
    @sender_email = sender_email
    @body_text = body
    @sender_name = sender_name
    @type = type

    mail(:to => "photocaching@ars-subtilior.com", 
          :subject => "#{@type}: #{@subject_text}")
  end
end
