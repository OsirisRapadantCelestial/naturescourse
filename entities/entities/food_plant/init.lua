AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include('shared.lua')
local bo,ao = Vector(-5,-5,-5),Vector(5,5,5)
function ENT:Initialize()
	self:SetModel("models/naturescourse/models/plant_matter.mdl")
	self:SetAmount( math.random( 4, 9 )  )
	self:PhysicsInit(SOLID_VPHYSICS)
  --  self:SetMoveType(MOVETYPE_)
    self:SetSolid(SOLID_VPHYSICS)

	self:SetCollisionGroup(COLLISION_GROUP_IN_VEHICLE)
	self.Phys = self:GetPhysicsObject()
	self.Phys:Wake()
	self.Phys:EnableMotion(false)

	self.foodType = "plant"
end


function ENT:Use(ent)
end
