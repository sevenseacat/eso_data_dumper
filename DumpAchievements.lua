function DataDumper.DumpAchievements()
  d("DataDumper: Dumping achievements")
  DataDumper.achievements["Categories"] = {}

  -- Total counts, to be used in generating the summary
  totalNumAchievements = 0

  -- Iterate over the top level categories, eg. 'Crafting'
  for index = 1, GetNumAchievementCategories() do
    name, subCategoryCount, categoryNumAchievements, _, categoryPoints = GetAchievementCategoryInfo(index)

    -- Keep a running total
    totalNumAchievements = totalNumAchievements + categoryNumAchievements

    DataDumper.achievements["Categories"][index] =
      { Name = name, numAchievements = categoryNumAchievements, totalPoints = categoryPoints, subCategories = {} }

    -- Iterate over the sub-categories, eg. 'Alchemy', 'Woodworking'
    totalSubcategoryPoints = 0
    for subIndex = 1, subCategoryCount do
      name, numAchievements, _, points = GetAchievementSubCategoryInfo(index, subIndex)

      -- Keep a running total
      totalSubcategoryPoints = totalSubcategoryPoints + points
      totalNumAchievements = totalNumAchievements + numAchievements

      DataDumper.achievements["Categories"][index]["subCategories"][subIndex] =
        { Name = name, numAchievements = numAchievements, totalPoints = points }
    end

    -- The "General" category is a special case - all of the top-level achievements that don't
    -- fit in a subcategory
    if categoryNumAchievements > 0 and subCategoryCount > 0 then
      DataDumper.achievements["Categories"][index]["subCategories"][0] =
        { Name = "General", numAchievements = categoryNumAchievements, totalPoints = categoryPoints-totalSubcategoryPoints }
    end
  end

  -- Write out the summary at the end
  DataDumper.achievements["Summary"] =
    { numAchievements = totalNumAchievements, totalPoints = GetTotalAchievementPoints() }
end
