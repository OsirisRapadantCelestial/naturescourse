
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
		ply:Spectate( OBS_MODE_CHASE )
		ply:SpectateEntity(ent)

		for x = 1, 100 do
			local food = ents.Create("food_meat")
			food:SetPos(Vector(math.Rand(-1024, 1024),math.Rand(-1024, 1024),0))
			food:SetModel("models/weapons/w_bugbait.mdl")
			food:Spawn()
			food:Activate()
		end

		ply.stats = {
			["Teeth"] = "Basic Teeth",
			["Body"] = "Basic Body",
			["Fin"] = "Basic Fin",
			["Gullet"] = "Basic Gullet",
			["Slots"] = {},
			["PH"] = math.random(5,7),
			["Oxygen"] = math.random(90, 110),
			["Temperature"] = math.random(18,23),
		}
		net.Start("SendStats")
			net.WriteEntity(ply)
			net.WriteTable(ply.stats)
		net.Broadcast()
	end

	SetPH(math.random(5,7))
	SetOxygen(100)
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

hook.Add("PlayerDisconnected", "sadasda", function(ply)
	ply.OutOfGame = true
	ply.Entity:Remove()
	ply.Entity = nil
end)


function EndRound()

end
