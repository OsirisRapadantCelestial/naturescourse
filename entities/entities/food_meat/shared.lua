ENT.Type = "anim"
ENT.Base = "base_anim"
ENT.PrintName	= "Meat Chunks"
ENT.Author		= "Anthony Fuller"
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
	if new == 0 then
		self:Remove()
	end
	self:SetModelScale(new, 0.5)
end
