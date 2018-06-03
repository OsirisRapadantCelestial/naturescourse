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
    if foodtype == "meat" && self.stats["eat"] == "Carnivore" then
        return true
    else
        return false
    end

    if foodtype == "plant" && self.stats["eat"] == "Herbivore" then
        return true
    else
        return false
    end

    if self.stats["eat"] == "Omnivore" then
        return true
    end
end
