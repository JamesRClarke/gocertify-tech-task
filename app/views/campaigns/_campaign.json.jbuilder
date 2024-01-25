json.extract! campaign, :id, :title, :description, :state, :published_at, :position, :created_at, :updated_at
json.url campaign_url(campaign, format: :json)
