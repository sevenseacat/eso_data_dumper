DataDumper = {}
DataDumper.name = "DataDumper"

-- Initialization code for the addon.
function DataDumper:Initialize()
  DataDumper.achievements = ZO_SavedVars:NewAccountWide("Achievements", 1)
  DataDumper.dyes = ZO_SavedVars:NewAccountWide("Dyes", 1)
  DataDumper.categories = ZO_SavedVars:NewAccountWide("Categories", 1)
end

function DataDumper.OnAddOnLoaded(event, addonName)
  -- The event fires whenever *any* addon loads - but we only care about when our own addon loads.
  if addonName == DataDumper.name then
    DataDumper:Initialize()
  end
end

function DataDumper.Dump(dumpType)
  if dumpType == "achievements" then
    DataDumper.DumpAchievements()
  elseif dumpType == "dyes" then
    DataDumper.DumpDyes()
  else
    d("DataDumper: Valid dump types are 'achievements', 'dyes' and 'quests'")
  end
end

-- Register our handler for the EVENT_ADD_ON_LOADED event.
EVENT_MANAGER:RegisterForEvent(DataDumper.name, EVENT_ADD_ON_LOADED, DataDumper.OnAddOnLoaded)

-- Set up the `/dump` slash cmmand - will be used as in `/dump achievements`
SLASH_COMMANDS["/dump"] = DataDumper.Dump
