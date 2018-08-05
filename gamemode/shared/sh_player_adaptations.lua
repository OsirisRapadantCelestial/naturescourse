

local meta = FindMetaTable("Player")


if SERVER then

	util.AddNetworkString("AddAdaptation")
	util.AddNetworkString("AddPart")
	util.AddNetworkString("UpdatePart")
	util.AddNetworkString("Request_Adapations")
	util.AddNetworkString("wipe_adapt")
	
	
	function meta:AddAdaptationSkill(name)
		if ADAPTATIONS[name] and !self:HasAdaptation(name) then
			if !self.adaptations then self.adaptations = {} end
			self.adaptations[name] = ADAPTATIONS[name]
			net.Start("AddAdaptation")
				net.WriteString(name)
			net.Send(self)
		end
	end
	
	
	function meta:WipeAdaptation()
		self.adaptations = {}
		net.Start("wipe_adapt")
		net.Send(self)
	end
	
	function meta:UpdateSkillSlot(num, adapt)
		local bod = ADAPTATIONS[self.stats["Body"]]
		if bod and bod.slots[num] then
			self.stats["Slots"][num] = ADAPTATIONS[adapt]
			net.Start("AddPart")
				net.WriteEntity(self)
				net.WriteDouble(num)
				net.WriteString(adapt)
			net.Broadcast()
		end
	end
	
	net.Receive("Request_Adapations", function(len, ply)
		local part = net.ReadString()
		local adapt = net.ReadString()
		
		if ply:HasAdaptation(adapt) then
			if ply:GetDNA() > ADAPTATIONS[adapt].cost then
				if ply.stats[part] == adapt then return end
			
				ply:AddDNA( -ADAPTATIONS[adapt].cost )
				ply:UpdatePart(part, adapt)
			end
		end
	end)
	
	net.Receive("Request_Adapation_Skill", function()
		-- UpdateSkillSlot
	end)
	
	
	
	local Parts = {
		["Body"] = 		2,
		["Teeth"] = 	1,
		["Fin"] = 		1,
		["Gullet"] = 	1,
	}
	
	function meta:UpdatePart(part, adapt)
		if !ADAPTATIONS[adapt] then return end -- Hacker?
		if  !Parts[part] then return end
		if Parts[part] == 2 then
			local slots = self.stats["Slots"]
			

			
			-- Clear slots
		end
		self.stats[part] = adapt
		net.Start("UpdatePart")
			net.WriteEntity(self)
			net.WriteString(part)
			net.WriteString(adapt)
		net.Broadcast()
		
	end
	
else
	net.Receive("AddPart", function()
		local self = net.ReadEntity()
		local slot = net.ReadDouble()
		local part = net.ReadString()
		self.stats["Slots"][slot] = ADAPTATIONS[part]
	end)
	
	net.Receive("UpdatePart", function()
		local self = net.ReadEntity()
		local slot = net.ReadString()
		local part = net.ReadString()
		self.stats[slot] = part
	end)
	
	
	net.Receive("AddAdaptation", function()
		local self = LocalPlayer()
		local str = net.ReadString()
		if! self.adaptations then self.adaptations = {} end
		self.adaptations[str] = ADAPTATIONS[str]
	end)

	net.Receive("wipe_adapt", function()
		LocalPlayer().adaptations = {}
	end)
end

function meta:GetAdptations()
	return self.adaptations || {}
end

function meta:HasAdaptation(adapt)
	return self:GetAdptations()[adapt]
end