json.array!(@natural_clients) do |natural_client|
  json.extract! natural_client, :id, :run_cli
  json.url natural_client_url(natural_client, format: :json)
end
