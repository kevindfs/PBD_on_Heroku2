json.array!(@technical_review_expirations) do |technical_review_expiration|
  json.extract! technical_review_expiration, :id, :mes_venc_rev_tec, :num_venc_rev_tec
  json.url technical_review_expiration_url(technical_review_expiration, format: :json)
end
