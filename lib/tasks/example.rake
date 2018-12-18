desc 'send digest email'
task send_weekly_email: :environment  do
  # ... set options if any
  WeeklyDigestMailer.weekly_promos(options).deliver!
end
