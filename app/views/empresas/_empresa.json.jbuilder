json.extract! empresa, :id, :imgLogo, :imgLogoAlt, :name, :description, :mapLon, :mapLat, :tag_id, :offer_id, :schedule, :direction, :web, :email, :tel, :user_id, :photo_id, :video, :created_at, :updated_at
json.url empresa_url(empresa, format: :json)
