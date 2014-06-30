json.array!(@clients) do |client|
  json.extract! client, :id, :run_cli, :nom_cli, :apells_cli, :tel1_cli, :tel2_cli, :email_cli
  json.url client_url(client, format: :json)
end
