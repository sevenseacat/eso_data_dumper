function DataDumper.DumpDyes()
  d("DataDumper: Dumping dyes...")
  DataDumper.dyes["list"] = {}

  for index = 1, GetNumDyes() do
    dye = Dye.new(index)
    DataDumper.dyes["list"][index] = dye:toDump()
  end
  d("DataDumper: Done.")
end
