AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include('shared.lua')

function ENT:Initialize()
	self:SetModel("models/props_junk/watermelon01_chunk01b.mdl")
	self:SetCollisionGroup(COLLISION_GROUP_NONE)
	self.Phys = self:GetPhysicsObject()
	self.Phys:Wake()
	self:SetAmount( math.random( 4, 9 )  )
	self.foodType = "plant"
end


function ENT:Use(ent)
end
