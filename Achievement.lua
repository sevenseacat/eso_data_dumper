Achievement = {}
Achievement.__index = Achievement

-- Initialize the achievement, including loading its attributes, criteria, and rewards
function Achievement.new(id)
  local self = setmetatable({}, Achievement)

  self.id = id
  self.name,
  self.description,
  self.points = GetAchievementInfo(self.id)

  return self
end
