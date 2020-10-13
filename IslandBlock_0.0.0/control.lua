islandblock = {}

islandblock.giveitems = function(entity)
  local stuff = {
    {"boat", 1}
  }
  for _,v in ipairs(stuff) do
    entity.insert{name = v[1], count = v[2]}
  end
end

script.on_event(defines.events.on_player_created, function(e)
  islandblock.giveitems(game.players[e.player_index])
end)

script.on_event(defines.events.on_player_respawned, function(e)
  islandblock.giveitems(game.players[e.player_index])
end)