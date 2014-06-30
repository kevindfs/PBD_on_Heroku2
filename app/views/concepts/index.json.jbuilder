json.array!(@concepts) do |concept|
  json.extract! concept, :id, :nom_conc
  json.url concept_url(concept, format: :json)
end
