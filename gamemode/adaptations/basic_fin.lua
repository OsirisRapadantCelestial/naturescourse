local tbl = {}
tbl.Name = "Basic Fin"
tbl.Model = "models/hunter/blocks/cube025x05x025.mdl"
tbl.desc = ""
tbl.type = "Fin"
tbl.scale = 0.5
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
