Category = {}
Category.__index = Category

-- Initialize the category, including loading its attributes and subcategories
function Category.new(id)
  local self = setmetatable({}, Category)

  self.id = id
  self.name,
  self.subCategoryCount,
  self.achievementCount,
  _,
  self.pointsCount = GetAchievementCategoryInfo(self.id)
  self.subCategories = {}
  self:loadSubCategories()

  return self
end

-- Dump out the category into a format that can be placed in the saved variable
function Category:toDump()
  subCategoryDump = {}
  for index, subCategory in pairs(self.subCategories) do
    subCategoryDump[index] = subCategory:toDump()
  end

  category = {
    name = self.name,
    subCategoryCount = self.subCategoryCount,
    pointsCount = self.pointsCount,
  }

  if self.subCategoryCount > 0 then
    category["subCategories"] = subCategoryDump
    if self.achievementCount > 0 then
      category["subCategoryCount"] = category["subCategoryCount"] + 1
    end
  else
    category["achievementCount"] = self.achievementCount
  end

  return category
end

function Category:loadSubCategories()
  subCategoryPointsCount = 0

  for index = 1, self.subCategoryCount do
    -- Arrays are indexed from 1, so we have to increment by 1 in case "General"
    -- needs to slot in at the start
    self.subCategories[index+1] = SubCategory.new(self.id, index)
    subCategoryPointsCount = subCategoryPointsCount + self.subCategories[index+1].pointsCount
  end

  -- The "General" sub-category is a special case
  -- If there are top-level achievements AND sub-categories, then they go in a "General" sub-category
  if self.achievementCount > 0 and self.subCategoryCount > 0 then
    general = SubCategory.new(self.id, nil)
    general.achievementCount = self.achievementCount
    general.pointsCount = self.pointsCount - subCategoryPointsCount
    self.subCategories[1] = general
  end
end

function Category:totalAchievementCount()
  if self.subCategoryCount == 0 then
    count = self.achievementCount
  else
    count = 0
    for index, subCategory in pairs(self.subCategories) do
      count = count + subCategory.achievementCount
    end
  end

  return count
end
