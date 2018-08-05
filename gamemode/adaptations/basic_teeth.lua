local tbl = {}
tbl.Name = "Basic Teeth"
tbl.Model = {
	[1] = {0, false},
}
tbl.Color = Color(255,255,255)
tbl.type = "Teeth"
tbl.desc = "Just a bit gummy."
tbl.default = true
tbl.cost = 0
tbl.Teeth = "Omnivore"
tbl.effects = {
	["HUD"] = function(self)

	end,
	["Skill"] = function(self)

	end,
	["Damage"] = function(self, dmg)
		return dmg
	end,
	["Death"] = function(self)

	end,
	["Evolve"] = function(self)

	end,
}
RegisterAdaptation(tbl)
local tb = {
	"Carnivore",
	"Herbivore",
	"Omnivore",
}
for index, type in pairs(tb) do
	for x = 1, 10 do
		local tbl = {}
		tbl.Name = "Tier " .. x .. " Teeth " .. type
		tbl.Model ={
			[1] = {2-(1+index)%2, false},
		}
		tbl.type = "Teeth"
		tbl.Color = Color(255,255,0)
		tbl.desc = "Teeth which do " .. x .. " times damage"
		tbl.default = true
		tbl.cost = x * 20
		tbl.Teeth = type
		tbl.effects = {
			["HUD"] = function(self)

			end,
			["Skill"] = function(self)

			end,
			["Damage"] = function(self, dmg)
				return dmg * x
			end,
			["Death"] = function(self)

			end,
			["Evolve"] = function(self)

			end,
		}
		RegisterAdaptation(tbl)
	end
end
