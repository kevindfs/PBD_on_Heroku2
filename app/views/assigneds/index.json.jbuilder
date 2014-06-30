json.array!(@assigneds) do |assigned|
  json.extract! assigned, :id, :id_veh, :run_driv, :ini_assigned, :fin_assigned
  json.url assigned_url(assigned, format: :json)
end
