local tbl = {}
tbl.Name = "Basic Teeth"
tbl.Model = "models/hunter/blocks/cube025x05x025.mdl"
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
	["Damage"] = function(self)

	end,
	["Death"] = function(self)

	end,
	["Evolve"] = function(self)

	end,
}
RegisterAdaptation(tbl)


local tbl = {}
tbl.Name = "Basic Teeth v2"
tbl.Model = "models/hunter/blocks/cube025x05x025.mdl"
tbl.type = "Teeth"
tbl.desc = "Just a bit gummier."
tbl.default = true
tbl.cost = 100
tbl.Teeth = "Omnivore"
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
}
RegisterAdaptation(tbl)
