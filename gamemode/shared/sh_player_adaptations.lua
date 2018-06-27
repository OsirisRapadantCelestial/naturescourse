

local meta = FindMetaTable("Player")


if SERVER then

	util.AddNetworkString("AddAdaptation")
	util.AddNetworkString("AddPart")

	function meta:AddAdaptationSkill(name)
		if ADAPTATIONS[name] and !self:HasAdaptationSkill(name) then
			self.adaptations[name] = ADAPTATIONS[name]
			net.Start("AddAdaptation")
				net.WriteString(name)
			net.Send(self)
		end
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
else
	net.Receive("AddPart", function()
		local self = net.ReadEntity()
		local slot = net.ReadDouble()
		local part = net.ReadString()
		self.stats["Slots"][slot] = ADAPTATIONS[part]
	end)
	
	net.Receive("AddAdaptation", function()
		local self = LocalPlayer()
		local str = net.ReadString()
		if! self.adaptations then self.adaptations = {} end
		self.adaptations[str] = ADAPTATIONS[name]
	end)

end

function meta:GetAdptations()
	return ADAPTATIONS
end