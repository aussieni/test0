Rails.application.routes.draw do
  get '/tags/:entity_type/:entity_id' => 'tags#show'
  post '/tag' => 'tags#create'
  delete '/tags/:entity_type/:entity_id' => 'tags#delete'

  get '/stats/:entity_type/:entity_id' => 'tags#entity_stats'
  get '/stats' => 'tags#stats'
end
