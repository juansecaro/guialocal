class WeeklyDigestMailer < ApplicationMailer
  default :from => "info@adeter.org"
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.weekly_digest_mailer.weekly_promos.subject
  #
  helper ApplicationHelper

  def weekly_promos(suscriptor, promos)
      attachments.inline["logo.png"] = File.read("#{Rails.root}/app/assets/images/#{ENV['CURRENT_CITY']}/logoguia.png")
      @promos = promos
      mail(:to => "<#{suscriptor.email}>", :subject => "Mercadillo digital semanal de Guia#{ENV['CURRENT_CITY_CAP']}.es")
  end
end
