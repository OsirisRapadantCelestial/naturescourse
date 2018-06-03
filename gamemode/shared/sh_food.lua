local plymeta = FindMetaTable( "Player" )

if SERVER then

    util.AddNetworkString( "Food" )

    function plymeta:AddFood( amount )
		local food = GetFood()
		SetFood(food + amount)
    end

    function plymeta:SetFood( amount )
		net.Start("Food")
			net.WriteDouble(amount)
		net.Broadcast()
    end

else

    net.Receive( "Food", function( len, pl )
		pl.stats["Food"] = net.ReadDouble()
    end)

end

function plymeta:GetFood()
	return self.stats["Food"] || 0
end
