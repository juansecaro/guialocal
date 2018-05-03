json.extract! incident, :id, :subject, :info, :status, :user_id, :created_at, :updated_at
json.url incident_url(incident, format: :json)
