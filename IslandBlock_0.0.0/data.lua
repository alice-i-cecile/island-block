require "prototypes/recipe"
require "prototypes/recipe-category"
require "prototypes/technology"
require "prototypes/rockchest"

local lib = require "lib"

table.insert(data.raw.character.character.crafting_categories, "crafting-handonly")

for _,v in pairs(data.raw.tile) do
  v.autoplace = nil
end