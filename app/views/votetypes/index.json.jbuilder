json.array!(@votetypes) do |votetype|
  json.extract! votetype, :id, :entity_id, :user_id, :entitytype_id, :value
  json.url votetype_url(votetype, format: :json)
end
