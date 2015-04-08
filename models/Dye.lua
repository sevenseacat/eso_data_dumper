Dye = {}
Dye.__index = Dye

-- Initialize the dye
function Dye.new(id)
  local self = setmetatable({}, Dye)

  self.id = id
  self.name,
  _,
  self.rarity,
  self.hueCategory,
  self.achievementId,
  self.r,
  self.g,
  self.b,
  self.sortKey = GetDyeInfo(self.id)
  return self
end

function Dye:toDump()
  return {
    id = self.id,
    name = self.name,
    rarity = self.rarity,
    hueCategory = self.hueCategory,
    r = self.r,
    g = self.g,
    b = self.b,
    sortKey = self.sortKey
  }
end
