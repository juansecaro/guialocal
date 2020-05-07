class SuscriptorMailer < ApplicationMailer
  default :from => "info@adeter.org"

  def new_prospect_notification(prospect)
    @prospect = prospect
    mail(
      :to => "<info@gmail.com>",
      :subject => "Nuevo prospect: #{@prospect.user_first_name} #{@prospect.user_last_name}"
    )
  end
end
