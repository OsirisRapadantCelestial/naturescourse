AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include('shared.lua')
local bo,ao = Vector(-5,-5,-5),Vector(5,5,5)
function ENT:Initialize()
	self:SetModel("models/weapons/w_bugbait.mdl")
	self:PhysicsInitBox(bo,ao)
	self:SetCollisionGroup(COLLISION_GROUP_NONE)
	self.Phys:EnableMotion(false)
	self.Phys = self:GetPhysicsObject()
	self.Phys:Wake()
	self:SetAmount( math.random( 5, 10 )  )
	self.foodType = "meat"
end


function ENT:Use(ent)
end
