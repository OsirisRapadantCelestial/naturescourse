local tbl = {}
tbl.Name = "Basic Fin"
tbl.Model = {
	[0] = {1, false},
}
tbl.desc = "Just keep on swimming"
tbl.Color = Color(0,255,0)
tbl.type = "Fin"
tbl.default = true
tbl.slots = nil
tbl.cost = 0
tbl.effects = {
	["HUD"] = function(self)

	end,
	["Skill"] = function(self)

	end,
	["Damage"] = function(self)

	end,
	["Death"] = function(self)

	end,
	["Evolve"] = function(self)

	end,
	["Speed"] = function(self, speed)
		return speed *2
	end,
}
RegisterAdaptation(tbl)


for x = 1, 10 do
local tbl = {}
tbl.Name = "Teir " .. x .. " Fin"
tbl.Model = {
	[0] = {1, false},
}
tbl.desc = "Just keep on swimming " .. x .. " times faster"
tbl.Color = Color(0,255,0)
tbl.type = "Fin"
tbl.default = true
tbl.slots = nil
tbl.cost = x * 10
tbl.effects = {
	["HUD"] = function(self)

	end,
	["Skill"] = function(self)

	end,
	["Damage"] = function(self)

	end,
	["Death"] = function(self)

	end,
	["Evolve"] = function(self)

	end,
	["Speed"] = function(self, speed)
		return speed *x*2
	end,
}
RegisterAdaptation(tbl)
end
