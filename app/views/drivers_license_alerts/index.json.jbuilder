json.array!(@drivers_license_alerts) do |drivers_license_alert|
  json.extract! drivers_license_alert, :id, :plant_alert_licenc
  json.url drivers_license_alert_url(drivers_license_alert, format: :json)
end
