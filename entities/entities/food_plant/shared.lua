ENT.Type = "anim"
ENT.Base = "base_anim"
ENT.PrintName	= "Plant Matter"
ENT.Author		= "Anthony Fuller + Star Light"
ENT.Category = "ORC"
ENT.Spawnable = true
function ENT:OnRemove()
end

function ENT:SetupDataTables()
	self:NetworkVar("Int", 0, "Amount")
	if SERVER then
		self:NetworkVarNotify("Amount", self.OnAmountChange)
	end
end

function ENT:OnAmountChange(name, old, new)
	if new < 1 then
		self:Remove()
		return
	end

	local new = new/16

	self:SetModelScale(new, 0.5)
end
