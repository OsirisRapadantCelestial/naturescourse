ENT.Type = "anim"
ENT.Base = "base_anim"
ENT.PrintName	= "Base Food"
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
	self:SetModelScale(new, 0.5)
end