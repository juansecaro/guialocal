require 'open-uri'
require 'nokogiri'

desc 'send digest email'
task send_weekly_email: :environment  do

  @promociones = Promo.where("validez > ?", Time.zone.now).order("created_at DESC")
  if (@promociones.count > 0)
    @suscriptors = Suscriptor.where(email_confirmation: true)
    @suscriptors.each do |suscriptor|
        WeeklyDigestMailer.weekly_promos(suscriptor, @promociones).deliver_now
    end
  end

end

desc 'recover eventos llerena'
task recover_eventos_llerena: :environment  do

  enlaces = []

  # Getting index and all links
  url = ::URI.open("https://llerena.org/eventos/lista")
  page = ::Nokogiri::HTML(url)

  page.css("a.fusion-read-more").each do |line|
    enlaces.push(line.attr('href'))
  end

  enlaces = enlaces.uniq

  #Inspecting everyone of them
  enlaces.each do |link|
    url = ::URI.open(link)
    page = ::Nokogiri::HTML(url)

    title = page.css("h1").text
    if Evento.find_by_titulo(title) == nil

      description = page.css(".tribe-events-single-event-description.tribe-events-content.entry-content.description p").text
      date = page.css(".tribe-events-abbr").attr('title')
      image = page.css(".size-full").attr('src')

      Evento.create!(
      	titulo: title,
      	remote_imgevento_url: image,
      	info: description,
      	fecha: Date.parse(date)
      )

    end
  end


end
