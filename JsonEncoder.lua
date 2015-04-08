infile = arg[1]
json = require("dkjson")
dofile(infile)

achievements = json.encode(Achievements["Default"]["@sevenseacat"]["$AccountWide"]["list"], {indent=true})
output = io.open("output/achievements.json", "w")
output:write(achievements)
output:close()

dyes = json.encode(Dyes["Default"]["@sevenseacat"]["$AccountWide"]["list"], {indent=true})
output = io.open("output/dyes.json", "w")
output:write(dyes)
output:close()

categories = json.encode(Categories["Default"]["@sevenseacat"]["$AccountWide"]["list"], {indent=true})
output = io.open("output/categories.json", "w")
output:write(categories)
output:close()

print("JSON encoded and placed in ./output/.")
