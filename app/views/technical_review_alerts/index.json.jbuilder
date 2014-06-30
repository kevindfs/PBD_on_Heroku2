json.array!(@technical_review_alerts) do |technical_review_alert|
  json.extract! technical_review_alert, :id, :plant_alert_rev_tec
  json.url technical_review_alert_url(technical_review_alert, format: :json)
end
