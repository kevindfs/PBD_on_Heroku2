json.array!(@states) do |state|
  json.extract! state, :id, :nom_est
  json.url state_url(state, format: :json)
end
