ENT.Type = "anim"
ENT.Base = "base_anim"
ENT.PrintName	= "Meat Chunks"
ENT.Author		= "Anthony Fuller + StarLight"
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
	
	self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)
	
	self:SetModelScale(new, 0.5)
end
