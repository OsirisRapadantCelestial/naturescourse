AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

include( "shared.lua" )

function GM:Initialize()
    print( "Natural Selection Gamemode Loaded" ) -- Temp message
end


function GM:PlayerSpawn(ply)
	ply:SetPos(Vector(0,0,0))
	GAMEMODE:PlayerSpawnAsSpectator(ply)
	ply:Spectate( OBS_MODE_CHASE )
end