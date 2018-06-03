local plymeta = FindMetaTable( "Player" )

if SERVER then

    util.AddNetworkString( "Hunger" )

    function plymeta:AddHunger( amount )
		local hunger = GetHunger()
		SetHunger(hunger + amount)
    end

    function plymeta:SetHunger( amount )
		net.Start("Hunger")
			net.WriteDouble(amount)
		net.Broadcast()
    end

else

    net.Receive( "Hunger", function( len, pl )
		ply.stats["Hunger"] = net.ReadDouble()
    end)

end

function GetHunger()
	return ply.stats["Hunger"] || 0
end
