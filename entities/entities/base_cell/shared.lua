ENT.Type = "anim"
ENT.Base = "base_anim"
ENT.PrintName	= "Base Cell"
ENT.Author		= "Star Light"
ENT.Contact		= ""
ENT.MaxSpeed 	= 40
ENT.ShipSpeed = 1
ENT.MaxHealth = 100
ENT.Category = "ORC"
ENT.Spawnable = true
function ENT:OnRemove()
end

function ENT:SetupDataTables()
	self:NetworkVar("Entity", 0, "Player")
	self:NetworkVar("Int", 0, "NewHealth")
	if SERVER then
		self:SetNewHealth(self.MaxHealth)
	end
end 