
ROUNDSTARTED = false



function StartRound()
	ROUNDSTARTED = CurTime()
	for index, ply in pairs(player.GetAll()) do
		ply.OutOfGame = false
		
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
		
	timer.Simple(300, function()
		EventHappen()
	end)
end

function EventHappen()
	-- Randomly Choose from events
end


hook.Add("PlayerDeath", "remove entity", function(ply)
	ply.OutOfGame = true
	ply.Entity:Remove()
	ply.Entity = nil
end)





