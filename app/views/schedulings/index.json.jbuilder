json.array!(@schedulings) do |scheduling|
  json.extract! scheduling, :id, :id_off_veh, :run_driv, :run_cli
  json.url scheduling_url(scheduling, format: :json)
end
