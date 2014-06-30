json.array!(@enterprise_clients) do |enterprise_client|
  json.extract! enterprise_client, :id, :run_cli, :rut_ent
  json.url enterprise_client_url(enterprise_client, format: :json)
end
