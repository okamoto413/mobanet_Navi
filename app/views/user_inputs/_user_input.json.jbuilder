json.extract! user_input, :id, :user_id, :data_usage, :call_time, :sms_usage, :created_at, :updated_at
json.url user_input_url(user_input, format: :json)
