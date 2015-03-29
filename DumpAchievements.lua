function DataDumper.DumpAchievements()
  d("DataDumper: Dumping achievements")
  DataDumper.achievements["Categories"] = {}

  --  To keep a running tally of total achievement count
  achievementCount = 0

  for index = 1, GetNumAchievementCategories() do
    category = Category.new(index)
    achievementCount = achievementCount + category:totalAchievementCount()

    DataDumper.achievements["Categories"][index] = category:toDump()
  end

  DataDumper.achievements["Summary"] =
    { achievementCount = achievementCount, pointsCount = GetTotalAchievementPoints() }
end
