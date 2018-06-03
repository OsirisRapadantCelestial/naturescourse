function GetOxygen()

end

if SERVER then

    util.AddNetworkString( "Oxygen" )

    function SyncOxygen( ply )
        net.Start( "Oxygen" )
        net.Send(ply)
    end

    function AddOxygen( amount )

    end

    function SetOxygen( amount )

    end

else

    net.Receive( "Oxygen", function( len, pl )
        local enviroment = {
            oxygen = tonumber( GetOxygen() ),
        }
    end )

end
