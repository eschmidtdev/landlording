json.extract! subscription, :id, :email, :first_name, :last_name, :company, :address_line_one, :address_line_two, :city, :zip_code, :country, :state, :created_at, :updated_at
json.url subscription_url(subscription, format: :json)
