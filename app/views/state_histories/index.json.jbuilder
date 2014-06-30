json.array!(@state_histories) do |state_history|
  json.extract! state_history, :id, :id_trav, :id_stat
  json.url state_history_url(state_history, format: :json)
end
