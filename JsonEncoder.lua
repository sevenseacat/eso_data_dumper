infile = arg[1]
json = require("dkjson")
dofile(infile)
os.execute("mkdir output")

for _, data in pairs(Achievements["Default"]) do
  achievements = json.encode(data["$AccountWide"]["list"], {indent=true})
  output = io.open("output/achievements.json", "w")
  output:write(achievements)
  output:close()
end

for _, data in pairs(Dyes["Default"]) do
  dyes = json.encode(data["$AccountWide"]["list"], {indent=true})
  output = io.open("output/dyes.json", "w")
  output:write(dyes)
  output:close()
end

for _, data in pairs(Categories["Default"]) do
  categories = json.encode(data["$AccountWide"]["list"], {indent=true})
  output = io.open("output/categories.json", "w")
  output:write(categories)
  output:close()
end

print("JSON encoded and placed in ./output/.")
