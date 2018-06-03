AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include('shared.lua')

function ENT:Initialize()
	self:SetModel("models/hunter/blocks/cube025x05x025.mdl")
	self:SetCollisionGroup(COLLISION_GROUP_NONE)
	self.Phys = self:GetPhysicsObject()
	self.Phys:Wake()

	local food = math.random( 5, 10 )
	self:SetAmount( tonumber( food ) )
end


function ENT:Use(ent)
end
