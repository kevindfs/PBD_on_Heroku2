json.array!(@fixed_rates) do |fixed_rate|
  json.extract! fixed_rate, :id, :ori_tar, :dest_tar, :costo_tar
  json.url fixed_rate_url(fixed_rate, format: :json)
end
