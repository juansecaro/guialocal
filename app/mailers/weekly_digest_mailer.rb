class WeeklyDigestMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.weekly_digest_mailer.weekly_promos.subject
  #
  def weekly_promos

    @promos = Promo.where("fecha > ?", Time.zone.now).order(created_at: :desc)

    Suscriptor.find_each do |suscriptor|
      mail(:to => "<#{suscriptor.email}>", :subject => "Mercadillo digital semanal de GuiaLlerena.es")
    end

  end
end
