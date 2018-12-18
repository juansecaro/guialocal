class SuscriptorMailer < ApplicationMailer
  default :from => "info@adeter.org"

  def registration_confirmation(suscriptor)
    @suscriptor = suscriptor
    mail(:to => "<#{suscriptor.email}>", :subject => "Confirmación de correo")
  end
end
