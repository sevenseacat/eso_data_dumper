Achievement = {}
Achievement.__index = Achievement

-- Initialize the achievement, including loading its attributes, criteria, and rewards
function Achievement.new(id)
  local self = setmetatable({}, Achievement)

  self.id = id
  self.name,
  self.description,
  self.points = GetAchievementInfo(self.id)
  self.isWorth = 1

  self.nextInLine = nil
  nextAch = GetNextAchievementInLine(self.id)
  if nextAch ~= 0 then
    self.nextInLine = nextAch
  end

  -- Each achievement may count for many - if it has more in line, it represents
  -- all of those to the parent subcategory or category
  if self.nextInLine then
    ach = self
    while ach.nextInLine do
      nextAch = Achievement.new(ach.nextInLine)
      self.isWorth = self.isWorth + 1
      ach = nextAch
    end
  end

  self:loadRewards()

  return self
end

function Achievement:toDump()
  achievement = { id = self.id, name = self.name, description = self.description, points = self.points, rewards = self.rewards }

  if self.nextInLine then
    achievement["nextInLine"] = self.nextInLine
  end

  return achievement
end

function Achievement:loadRewards()
  self.rewards = {}

  isAReward, rewardId = GetAchievementRewardDye(self.id)
  if isAReward then
    self.rewards["dyeId"] = rewardId
  end

  isAReward, rewardName = GetAchievementRewardItem(self.id)
  if isAReward then
    self.rewards["item"] = rewardName
  end

  isAReward, rewardName = GetAchievementRewardTitle(self.id)
  if isAReward then
    self.rewards["title"] = rewardName
  end
end
