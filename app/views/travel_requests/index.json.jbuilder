json.array!(@travel_requests) do |travel_request|
  json.extract! travel_request, :id, :run_cli, :dir_orig_sol, :dir_dest_sol, :com_orig_sol, :com_dest_sol, :cant_pasaj_sol, :fecha_crea_sol, :fecha_serv_sol, :est_sol
  json.url travel_request_url(travel_request, format: :json)
end
