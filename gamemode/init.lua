AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

include( "shared.lua" )

function GM:Initialize()
    print( "Natural Selection Gamemode Loaded" ) -- Temp message
end


function GM:PlayerSpawn(ply)
	ply:SetPos(Vector(0,0,0))
	GM:PlayerSpawnAsSpectator(ply)
	ply:Spectate( OBS_MODE_CHASE )
	
	local ent =  ents.Create("base_cell")
	ent:SetPos(Vector(0,0,0))
	ent:SetModel("models/hunter/blocks/cube025x05x025.mdl")
	ent:Spawn()
	ent:Activate()
	ent:SetPlayer(ply)
	ply:SpectateEntity(ent)
end