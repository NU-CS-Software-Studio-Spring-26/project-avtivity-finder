json.extract! activity, :id, :title, :description, :location, :city, :category, :event_date, :created_at, :updated_at
json.url activity_url(activity, format: :json)
