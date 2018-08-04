local tbl = {}
tbl.Name = "Basic Fin"
tbl.Model = {
	[0] = {1, false},
}
tbl.desc = ""
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
