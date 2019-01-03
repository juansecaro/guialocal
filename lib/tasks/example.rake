desc 'send digest email'
task send_weekly_email: :environment  do

  #@promociones = Promo.where("validez > ?", Time.zone.now).order("created_at DESC")
  @promociones = Promo.take(3)
  @suscriptors = Suscriptor.where(email_confirmation: true)

  @suscriptors.each do |suscriptor|
      WeeklyDigestMailer.weekly_promos(suscriptor, @promociones).deliver_now
  end
end
