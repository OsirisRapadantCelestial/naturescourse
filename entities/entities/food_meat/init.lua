AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include('shared.lua')
local bo,ao = Vector(-5,-5,-5),Vector(5,5,5)
function ENT:Initialize()
	self:SetModel("models/weapons/w_bugbait.mdl")
		
	self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)
	
	self:SetCollisionGroup(COLLISION_GROUP_NONE)
	
	self.Phys = self:GetPhysicsObject()
	self.Phys:Wake()
	self.Phys:EnableMotion(false)
	self:SetAmount( math.random( 5, 10 )  )
	self.foodType = "meat"
end


function ENT:Use(ent)
end
