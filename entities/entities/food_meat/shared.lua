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
end
