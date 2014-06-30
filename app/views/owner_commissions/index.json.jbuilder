json.array!(@owner_commissions) do |owner_commission|
  json.extract! owner_commission, :id, :porcent_comi_prop, :ini_comi_prop, :fin_comi_prop
  json.url owner_commission_url(owner_commission, format: :json)
end
