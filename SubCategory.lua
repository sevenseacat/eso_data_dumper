SubCategory = {}
SubCategory.__index = SubCategory

-- Initialize the subcategory, including loading its attributes
function SubCategory.new(parentId, id)
  local self = setmetatable({}, SubCategory)

  self.parentId = parentId
  self.id = id

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

function SubCategory:toDump()
  return {
    name = self.name,
    achievementCount = self.achievementCount,
    pointsCount = self.pointsCount
  }
end
