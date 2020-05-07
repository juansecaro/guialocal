class ProspectMailer < ApplicationMailer
  default from: "ADETER <info@adeter.org>"

  def new_prospect_notification(prospect)
    @prospect = prospect
    mail(
      :to => "<info@gmail.com>",
      :subject => "Nuevo prospect: #{@prospect.user_first_name} #{@prospect.user_last_name}"
    )
  end

  def prospect_confirmation(prospect)
    @prospect = prospect
    mail(
      :to => @prospect.user_email,
      :subject => "#{@prospect.user_first_name}, ya estamos tramitando tu alta"
    )
  end
end
