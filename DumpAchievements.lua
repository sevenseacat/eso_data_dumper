function DataDumper.DumpAchievements()
  d("DataDumper: Dumping achievements")
  DataDumper.achievements["Categories"] = {}

  for index = 1, GetNumAchievementCategories() do
    name, subCategoryCount, numAchievements, _, points = GetAchievementCategoryInfo(index)
    DataDumper.achievements["Categories"][index] = { Name = name, numAchievements = numAchievements, totalPoints = points, subCategories = {} }

    for subIndex = 1, subCategoryCount do
      name, numAchievements, _, points = GetAchievementSubCategoryInfo(index, subIndex)
      DataDumper.achievements["Categories"][index]["subCategories"][subIndex] = { Name = name, numAchievements = numAchievements, totalPoints = points }
    end
  end
end
