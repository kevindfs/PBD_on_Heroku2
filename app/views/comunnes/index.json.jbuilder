json.array!(@comunnes) do |comunne|
  json.extract! comunne, :id, :nom_comun, :num_comun
  json.url comunne_url(comunne, format: :json)
end
