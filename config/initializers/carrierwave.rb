
CarrierWave.configure do |config|

  if Rails.env.production?


    config.fog_provider = 'fog/aws'
    config.fog_directory = ENV["S3_BUCKET"]
    config.fog_credentials = {
      provider: "AWS",
      aws_access_key_id: ENV["S3_ACCESS_KEY"],
      aws_secret_access_key: ENV["S3_SECRET_ACCESS"],
      region: ENV["S3_REGION"]
    }
    config.storage = :fog
  else
    config.storage = :file
  end
end
