json.array!(@bills) do |bill|
  json.extract! bill, :id, :rut_ent, :fecha_fact, :total_fact
  json.url bill_url(bill, format: :json)
end
