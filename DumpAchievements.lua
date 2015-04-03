function DataDumper.DumpAchievements()
  d("DataDumper: Dumping achievements...")
  DataDumper.achievements["Categories"] = {}
  DataDumper.achievements["Achievements"] = {}

  --  To keep a running tally of total achievement count
  achievementCount = 0

  for index = 1, GetNumAchievementCategories() do
    category = Category.new(index)
    achievementCount = achievementCount + category:totalAchievementCount()

    -- Pull out all of the achievement details and store them separately
    DataDumper.DumpCollection(category.achievements)

    for _, subCategory in pairs(category.subCategories) do
      subCategory:loadAchievements()
      DataDumper.DumpCollection(subCategory.achievements)
    end

    DataDumper.achievements["Categories"][index] = category:toDump()
  end

  DataDumper.achievements["Summary"] =
    { achievementCount = achievementCount, pointsCount = GetTotalAchievementPoints() }
  d("DataDumper: Done.")
end

function DataDumper.DumpCollection(collection)
  for _, achievement in pairs(collection) do
    DataDumper.DumpAchievement(achievement)

    while achievement.nextInLine ~= 0 do
      achievement = Achievement.new(achievement.nextInLine)
      DataDumper.DumpAchievement(achievement)
    end
  end
end

function DataDumper.DumpAchievement(achievement)
  DataDumper.achievements["Achievements"][achievement.id] = achievement:toDump()
end
