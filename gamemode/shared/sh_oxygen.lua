
Environment = Environment || {}


if SERVER then

    util.AddNetworkString( "Oxygen" )

    function SyncOxygen( ply )
        net.Start( "Oxygen" )
        net.Send(ply)
    end

    function AddOxygen( amount )
		local oxy = GetOxygen()
		SetOxygen(oxy + amount)
    end

    function SetOxygen( amount )
		Environment["Oxygen"] = amount
		net.Start("Oxygen")
			net.WriteDouble(amount)
		net.Broadcast()
    end

else

    net.Receive( "Oxygen", function( len, pl )
		Environment["Oxygen"] = net.ReadDouble()
    end)

end

function GetOxygen()
	return Environment["Oxygen"] || 0
end
