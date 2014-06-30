json.array!(@kilometers_prices) do |kilometers_price|
  json.extract! kilometers_price, :id, :val_km, :ini_val_km, :fin_val_km, :estado_val_km
  json.url kilometers_price_url(kilometers_price, format: :json)
end
