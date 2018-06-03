if SERVER then

    util.AddNetworkString( "pH" )

    function SyncPH( ply )
        net.Start( "pH" )
        net.Send(ply)
    end

    function AddPH( amount )
		local ph = GetPH()
		SetPH(ph + amount)
    end

    function SetPH( amount )
		Environment["pH"] = amount
		net.Start("pH")
			net.WriteDouble(amount)
		net.Broadcast()
    end

else

    net.Receive( "pH", function( len, pl )
		Environment["pH"] = net.ReadDouble()
    end)

end

function GetPH()
	return Environment["pH"] || 0
end
