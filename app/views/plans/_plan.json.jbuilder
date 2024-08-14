json.extract! plan, :id, :name, :carrier, :monthly_fee, :data_capacity, :call_fee, :plan_type, :created_at, :updated_at
json.url plan_url(plan, format: :json)
