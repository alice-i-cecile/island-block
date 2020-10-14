local lib = require("lib")

-- Adjust resin production amount to how it was in petrochem 0.7.9.
-- TODO: Revisit this after Angel adds more liquid rubber recipes
lib.substresult('liquid-rubber-1', 'liquid-rubber', nil, 20)

-- Reset solid-resin recipe icon to remove the II stamp
data.raw.recipe['solid-resin'].icon = nil
data.raw.recipe['solid-resin'].icons = nil

-- Rename internal item names to keep mods like FNEI searching properly
local itemrename =
{
  ['solid-coke'] = 'wood-charcoal',
  ['filter-coal'] = 'filter-charcoal',
  ['pellet-coke'] = 'pellet-charcoal'
}

for k,v in pairs(itemrename) do
  local item = data.raw.item[k]
  data.raw.item[k] = nil
  item.name = v
  if not data.raw.item[v] then
    data.raw.item[v] = item
  end
end
local function updateline(line)
  local nameidx = 'name'
  if line[nameidx] == nil then
    nameidx = 1
  end
  local item = line[nameidx]
  if itemrename[item] then
    line[nameidx] = itemrename[item]
  end
end
local function updaterecipe(recipe)
  for _,v in pairs(recipe.ingredients) do
    updateline(v)
  end
  if recipe.result and itemrename[recipe.result] then
    recipe.result = itemrename[recipe.result]
  end
  for _,v in pairs(recipe.results or {}) do
    updateline(v)
  end
end
for _,v in pairs(data.raw.recipe) do
  lib.iteraterecipes(v, updaterecipe)
end

-- Recipes to unconditionally remove
local removerecipes = {}
for _,v in ipairs({
  'slag-processing-nuc',
  'alien-artifact-red-from-basic',
  'alien-artifact-orange-from-basic',
  'alien-artifact-yellow-from-basic',
  'alien-artifact-green-from-basic',
  'alien-artifact-blue-from-basic',
  'alien-artifact-purple-from-basic',
  'bob-distillery',
  'water-thermal-lithia',
  'thermal-water-filtering-1',
  'thermal-water-filtering-2',
  'protection-field-goopless',
  'slag-processing-7',
  'slag-processing-8',
  'slag-processing-9'
}) do
  removerecipes[v] = true
end
