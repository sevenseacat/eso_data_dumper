function DataDumper.DumpAchievements()
  d("DataDumper: Dumping achievements")
  DataDumper.achievements["Categories"] = {}

  for index = 1, GetNumAchievementCategories() do
    category = Category.new(index)
    DataDumper.achievements["Categories"][index] = category:toDump()
  end
end
