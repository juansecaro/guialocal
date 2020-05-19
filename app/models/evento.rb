class Evento < ApplicationRecord
  before_destroy :clean_s3, prepend: true

  mount_uploader :imgevento, ImgeventoUploader

  extend FriendlyId
  friendly_id :titulo, use: :slugged

  def should_generate_new_friendly_id?
    titulo_changed? || super
  end

  private

  # Uploading events through scraping public pages
  def self.update_source_llerena

    year = Time.now.year
    month = Time.now.month
    enlaces = []

    4.times do #4 Months in advance is enough
        url = open(URI.parse("https://llerena.org/eventos/#{year}-#{month.to_s.rjust(2, "0")}"))
        puts url
        page = Nokogiri::HTML(url)

        page.css("h3.tribe-events-month-event-title a[href]").each do |line|
            enlaces.push(line.attr('href'))
        end

        if (month==12)
            month = 1
        else
            month = month + 1
        end
    end

    enlaces = enlaces.uniq

    enlaces.each do |enlace|
      url = open(URI.parse(enlace))
      page = Nokogiri::HTML(url)
      title = page.css('h1').text
      text =  page.css('div.tribe-events-single-event-description p').text
      src = page.try { css('div.tribe-events-event-image img').attr('src') }
      date = page.try { css('abbr.tribe-events-abbr.tribe-events-start-date.published.dtstart').attr('title') }
      fecha = Date.parse(date)
      #Not fully functional yet, fails at some edge cases



      if (Evento.find_by_titulo(title) == nil)
        Evento.create!(
         titulo: title,
         remote_imgevento_url: src.value,
         info: text,
         fecha: fecha
        )
        end
      end

  end

  def clean_s3
    self.remove_imgevento!
  rescue Excon::Errors::Error => error
    puts "Something gone wrong"
    false
  end
end
