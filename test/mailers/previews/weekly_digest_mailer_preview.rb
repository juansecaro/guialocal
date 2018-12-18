# Preview all emails at http://localhost:3000/rails/mailers/weekly_digest_mailer
class WeeklyDigestMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/weekly_digest_mailer/weekly_promos
  def weekly_promos
    WeeklyDigestMailer.weekly_promos
  end

end
