json.array!(@vehicles) do |vehicle|
  json.extract! vehicle, :id, :run_own, :pat_veh, :mar_veh, :model_veh, :tipo_veh, :km_sem_veh
  json.url vehicle_url(vehicle, format: :json)
end
