function DataDumper.DumpAchievements()
  d("DataDumper: Dumping achievements...")
  DataDumper.categories["list"] = {}
  DataDumper.achievements["list"] = {}

  --  To keep a running tally of total achievement count
  achievementCount = 0

  for index = 1, GetNumAchievementCategories() do
    category = Category.new(index)

    -- Pull out all of the achievement details and store them separately
    DataDumper.DumpCollection(category.achievements)

    for _, subCategory in pairs(category.subCategories) do
      subCategory:loadAchievements()
      DataDumper.DumpCollection(subCategory.achievements)
    end

    achievementCount = achievementCount + category:totalAchievementCount()
    DataDumper.categories["list"][index] = category:toDump()
  end

  DataDumper.achievements["summary"] =
    { achievementCount = achievementCount, pointsCount = GetTotalAchievementPoints() }
  d("DataDumper: Done.")
end

function DataDumper.DumpCollection(collection)
  for _, achievement in pairs(collection) do
    DataDumper.DumpAchievement(achievement)

    while achievement.nextInLine do
      achievement = Achievement.new(achievement.nextInLine)
      DataDumper.DumpAchievement(achievement)
    end
  end
end

function DataDumper.DumpAchievement(achievement)
  current_count = #DataDumper.achievements["list"]
  DataDumper.achievements["list"][current_count+1] = achievement:toDump()
end
