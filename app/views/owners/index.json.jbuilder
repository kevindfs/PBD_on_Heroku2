json.array!(@owners) do |owner|
  json.extract! owner, :id, :run_own, :nom_prop, :apells_prop, :tel_prop, :email_prop
  json.url owner_url(owner, format: :json)
end
