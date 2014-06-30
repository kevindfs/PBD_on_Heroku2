json.array!(@base_prices) do |base_price|
  json.extract! base_price, :id, :val_base, :ini_val_base, :fin_val_base, :estado_val_base
  json.url base_price_url(base_price, format: :json)
end
