json.array!(@drivers) do |driver|
  json.extract! driver, :id, :run_driv, :nom_cond, :apells_cond, :tel1_cond, :tel2_cond, :email_cond, :venc_licenc_cond
  json.url driver_url(driver, format: :json)
end
