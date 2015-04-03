SubCategory = {}
SubCategory.__index = SubCategory

-- Initialize the subcategory, including loading its attributes
function SubCategory.new(parentId, id)
  local self = setmetatable({}, SubCategory)

  self.parentId = parentId
  self.id = id
  self.achievements = {}
  self.isWorth = 0

  if self.id ~= nil then
    self.name,
    self.achievementCount,
    _,
    self.pointsCount = GetAchievementSubCategoryInfo(self.parentId, self.id)
  else
    self.name = "General"
  end

  return self
end

function SubCategory:loadAchievements()
  for index = 1, self.achievementCount do
    ach = Achievement.new(
      GetAchievementId(self.parentId, self.id, index)
    )
    self.achievements[index] = ach
    self.isWorth = self.isWorth + ach.isWorth
  end
end

function SubCategory:toDump()
  subcategory = {
    name = self.name,
    achievementCount = self.isWorth,
    pointsCount = self.pointsCount
  }

  achievementIds = {}
  for index, achievement in pairs(self.achievements) do
    achievementIds[index] = achievement.id
  end
  subcategory["achievementIds"] = achievementIds

  return subcategory
end
