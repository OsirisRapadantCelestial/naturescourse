local plymeta = FindMetaTable( "Player" )

local foodtype = {
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
    if foodtype == "meat" && self.stats["eat"] == "Carnivore" || self.stats["eat"] == "Omnivore" then
        return true
    else
        return false
    end

    if foodtype == "plant" && self.stats["eat"] == "Herbivore" || self.stats["eat"] == "Omnivore" then
        return true
    else
        return false
    end
end
