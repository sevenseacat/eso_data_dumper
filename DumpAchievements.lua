function DataDumper.DumpAchievements()
  d("DataDumper: Dumping achievements")
  for index = 1, GetNumAchievementCategories() do
    name, subCategoryCount, numAchievements = GetAchievementCategoryInfo(index)
    DataDumper.achievements[index] = { Name = name, subCategoryCount = subCategoryCount, numAchievements = numAchievements }
  end
end
