json.array!(@travels) do |travel|
  json.extract! travel, :id, :run_driv, :id_trav_req, :hora_ini_via, :tiemp_est_via, :dist_est_via, :val_via
  json.url travel_url(travel, format: :json)
end
