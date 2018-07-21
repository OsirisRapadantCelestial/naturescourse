TEMP_MAX = 100
TEMP_MIN = 0
TEMP_BANDS = 5
if SERVER then

    util.AddNetworkString( "Temperature" )

    function SyncTemperature( ply )
        net.Start( "Temperature" )
			net.WriteDouble(GetTemperature())
        net.Send(ply)
    end

    function AddTemperature( amount )
		local temp = GetTemperature()
		SetTemperature(temp + amount)
    end

    function SetTemperature( amount )
        amount = math.Clamp(amount, TEMP_MIN, TEMP_MAX)
		Environment["Temperature"] = amount
		net.Start("Temperature")
			net.WriteDouble(amount)
		net.Broadcast()
    end

else

    net.Receive( "Temperature", function( len, pl )
		Environment["Temperature"] = net.ReadDouble()
    end)

end

function GetTemperature()
	return Environment["Temperature"] || 0
end
