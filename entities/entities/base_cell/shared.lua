ENT.Type = "anim"
ENT.Base = "base_anim"
ENT.PrintName	= "Base Cell"
ENT.Author		= "StarLight"
ENT.Contact		= ""
ENT.MaxSpeed 	= 40
ENT.ShipSpeed = 0
ENT.Category = "ORC"
ENT.Spawnable = true
function ENT:OnRemove()
end

function ENT:SetupDataTables()
	self:NetworkVar("Entity", 0, "Player")
end