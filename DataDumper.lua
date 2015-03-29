DataDumper = {}
DataDumper.name = "DataDumper"

-- Initialization code for the addon.
function DataDumper:Initialize()
end

function DataDumper.OnAddOnLoaded(event, addonName)
  -- The event fires whenever *any* addon loads - but we only care about when our own addon loads.
  if addonName == DataDumper.name then
    DataDumper:Initialize()
  end
end

-- Register our handler for the EVENT_ADD_ON_LOADED event.
EVENT_MANAGER:RegisterForEvent(DataDumper.name, EVENT_ADD_ON_LOADED, DataDumper.OnAddOnLoaded)
