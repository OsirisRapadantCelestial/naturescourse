ROUNDSTARTED = false


local spawnpos = (21504-50)/2

function StartRound()

	if #player.GetAll() == 1 then
		return
	end

	ROUNDSTARTED = CurTime()
	for index, ply in pairs(player.GetAll()) do
		ply.OutOfGame = false
		local ent =  ents.Create("base_cell")
		ply:SetPos(Vector(0,0,0))
		ent:SetPos(Vector(0,0,0))
		timer.Simple(0.5, function()
		ent:SetPos(Vector(math.Rand(-spawnpos, spawnpos), math.Rand(-spawnpos, spawnpos), math.Rand(100, spawnpos)) )
		end)
		ent:SetModel("models/hunter/blocks/cube025x05x025.mdl")
		ent:Spawn()
		ent:Activate()
		ent:SetPlayer(ply)
		ply:WipeAdaptation()
		ply.Entity = ent
		ply:Spectate(OBS_MODE_NONE )


		if ply:GetPermaAdpataion() then
			for x = 1, ply:GetPermaAdpataion() do
				ply:AddAdaptationSkill(GetRandomAdaptation())
			end
		end


		--ply:SpectateEntity(ent)

		local howmanyplant = math.random( 10, 100 )
		local howmanymeat = math.random( 10, 100 )
		local howmanydna = math.random( 10, 100 )

		for x = 1, howmanyplant do
			local food = ents.Create("food_plant")
			food:SetPos(Vector(math.Rand(-spawnpos, spawnpos), math.Rand(-spawnpos, spawnpos), math.Rand(100, spawnpos)) )
			food:Spawn()
			food:Activate()
		end

		for x = 1, howmanymeat do
			local food = ents.Create("food_meat")
			food:SetPos(Vector(math.Rand(-spawnpos, spawnpos), math.Rand(-spawnpos, spawnpos), math.Rand(100, spawnpos)) )
			food:Spawn()
			food:Activate()
		end

		for x = 1, howmanydna do
			local food = ents.Create("dna_points")
			food:SetPos(Vector(math.Rand(-spawnpos, spawnpos), math.Rand(-spawnpos, spawnpos), math.Rand(100, spawnpos)) )
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
			["Color"] = Color( math.Rand(0,255),math.Rand(0,255), math.Rand(0,255), 255 ),
		}
		net.Start("SendStats")
			net.WriteEntity(ply)
			net.WriteTable(ply.stats)
		net.Broadcast()

		ply:SetDNA(0)
	end

	SetPH(math.random(5,7))
	SetOxygen(100)
	timer.Simple(300, function()
		EventHappen(300)
	end)

	timer.Simple(1, function()
		CheckRound()
	end)

end

function EventHappen(oldtime)
	local howmanyplant = math.random( 1, 5 )
	local howmanymeat = math.random( 1, 5 )
	local howmanydna = math.random( 1, 5 )

	for x = 1, howmanyplant do
		local food = ents.Create("food_plant")
		food:SetPos(Vector(math.Rand(-spawnpos, spawnpos), math.Rand(-spawnpos, spawnpos), math.Rand(100, spawnpos)) )
		food:Spawn()
		food:Activate()
	end

	for x = 1, howmanymeat do
		local food = ents.Create("food_meat")
		food:SetPos(Vector(math.Rand(-spawnpos, spawnpos), math.Rand(-spawnpos, spawnpos), math.Rand(100, spawnpos)) )
		food:Spawn()
		food:Activate()
	end

	for x = 1, howmanydna do
		local food = ents.Create("dna_points")
		food:SetPos(Vector(math.Rand(-spawnpos, spawnpos), math.Rand(-spawnpos, spawnpos), math.Rand(100, spawnpos)) )
		food:Spawn()
		food:Activate()
	end

	timer.Simple(oldtime/2, function()
		EventHappen(math.Clamp(oldtime/2, 60, 300))
	end)

	if CurTime() - ROUNDSTARTED  > 600 then
		ROUNDSTARTED = CurTime() - 400
		local tbl = {}
		for index, ply in pairs(player.GetAll()) do
			if IsValid(ply.Entity) then
				tbl[#tbl+1] = ply.Entity
			end
		end
		table.Random(tbl):GetPlayer():Spectate(OBS_MODE_ROAMING)
		table.Random(tbl):Remove()
		CheckRound()
	end


end

function CheckRound()
	    local count = 0

	    for index, ply in pairs(player.GetAll()) do
		if IsValid(ply.Entity) then
		    count = count + 1
		end
	    end

	    if !ROUNDSTARTED then return end

	    if count >= 2 then
		timer.Simple(1, function()
		CheckRound()
		end)
	    return end -- Round is fine

	 ROUNDSTARTED = false

	local pl = nil

	for index, ply in pairs(player.GetAll()) do
		if IsValid(ply.Entity) then
			pl = ply
		end
	end

	if IsValid(pl) then
		pl:AddPermaAdpataion(1)
	end

	local p = nil
	local val = 0

	for index, ply in pairs(player.GetAll()) do
		if ply:GetFood() > val then
			val = ply:GetFood()
			p = ply
		end
	end
	p:AddPermaAdpataion(1)

	SendOutMessage( {Color(0,255,0), "[Natural Course] Round Over! New round starting in 5" })



	for index, ply in pairs(player.GetAll()) do
		if IsValid(ply.Entity) then
			ply.Entity:Remove()
		end

		if ply == p or ply == pl then
			ply:AddWin(1)
		else
			ply:AddLoss(1)
		end

	end


	for index, ent in pairs(ents.FindByClass("food_meat"))  do
		ent:Remove()
	end

	for index, ent in pairs(ents.FindByClass("food_plant"))  do
		ent:Remove()
	end

	for index, ent in pairs(ents.FindByClass("dna_points"))  do
		ent:Remove()
	end

	timer.Simple(5, function()
		StartRound()
	end)
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
