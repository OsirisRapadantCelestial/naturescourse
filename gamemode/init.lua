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
	
	local ent =  ents.Create("base_cell")
	ent:SetPos(Vector(0,0,0))
	ent:SetModel("models/hunter/blocks/cube025x05x025.mdl")
	ent:Spawn()
	ent:Activate()
	ent:SetPlayer(ply)
	ply.Entity = ent
	ply:SpectateEntity(ent)
	
	
	for x = 1, 100 do
		local food = ents.Create("food_meat")
		food:SetPos(Vector(math.Rand(-1024, 1024),math.Rand(-1024, 1024),0))
		food:SetModel("models/weapons/w_bugbait.mdl")
		food:Spawn()
		food:Activate()
	end
	
	
	
end