function DataDumper.DumpAchievements()
  d("DataDumper: Dumping achievements")
  DataDumper.achievements["Categories"] = {}
  DataDumper.achievements["Achievements"] = {}

  --  To keep a running tally of total achievement count
  achievementCount = 0

  for index = 1, GetNumAchievementCategories() do
    category = Category.new(index)
    achievementCount = achievementCount + category:totalAchievementCount()

    -- Pull out all of the achievement details and store them separately
    for _, achievement in pairs(category.achievements) do
      DataDumper.achievements["Achievements"][achievement.id] = achievement:toDump()
    end

    for _, subCategory in pairs(category.subCategories) do
      subCategory:loadAchievements()
      for _, achievement in pairs(subCategory.achievements) do
        DataDumper.achievements["Achievements"][achievement.id] = achievement:toDump()
      end
    end

    DataDumper.achievements["Categories"][index] = category:toDump()
  end

  DataDumper.achievements["Summary"] =
    { achievementCount = achievementCount, pointsCount = GetTotalAchievementPoints() }
end
