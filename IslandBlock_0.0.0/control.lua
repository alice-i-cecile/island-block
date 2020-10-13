islandblock = {}

islandblock.giveresearch = function(force)
  local techs = {
    'landfill',
    'bio-paper-1',
    'bio-processing-brown'
  }
  local newforce = force.technologies['sb-startup1'].researched == false
  for _,v in ipairs(techs) do
    force.technologies[v].researched = true
  end
  if newforce then
    force.add_research("sb-startup1")
  end
end

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

script.on_event(defines.events.on_player_joined_game, function(e)
  islandblock.giveresearch(game.players[e.player_index].force)
end)

script.on_event(defines.events.on_force_created, function(e)
  islandblock.giveresearch(e.force)
end)

local function setpvp()
  if remote.interfaces.pvp then
    remote.call("pvp", "set_config", {silo_offset = {x = 16, y = 16}})
  end
end

script.on_load(function()
  setpvp()
end)
