json.extract! event, :id, :start, :end, :name, :created_at, :updated_at
json.url event_url(event, format: :json)
