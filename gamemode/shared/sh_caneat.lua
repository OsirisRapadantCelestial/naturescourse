local plymeta = FindMetaTable( "Player" )

local foodtypes = {
    ["meat"] = {
        ["Carnivore"] = true,
        ["Omnivore"] = true,
    },
    ["plant"] = {
        ["Herbivore"] = true,
        ["Omnivore"] = true,
    },
}

function plymeta:CanEat( foodtype )
	return foodtypes[foodtype][self.stats["Teeth"]]
end
