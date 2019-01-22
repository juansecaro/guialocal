class ApplicationMailer < ActionMailer::Base
  default from: "Mercadillo Digital #{ENV['CURRENT_CITY_CAP']} <info@adeter.org>"
  'Sender Name <sender@example.com>'
  layout 'mailer'
end
