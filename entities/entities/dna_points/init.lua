AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include('shared.lua')

function ENT:Initialize()
	self:SetModel("models/naturescourse/models/dna_strand.mdl")
	
	self:PhysicsInit(SOLID_VPHYSICS)
    self:SetSolid(SOLID_BBOX)
	self:SetCollisionBounds( -Vector(32,32,32), Vector(32,32,32) )

	self:SetCollisionGroup(COLLISION_GROUP_IN_VEHICLE)
	self.Phys = self:GetPhysicsObject()
	self.Phys:Wake()
	self.Phys:EnableMotion(false)
	self.Adapation = GetRandomAdaptation()
end


function ENT:Use(ent)
end
