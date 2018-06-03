AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include('shared.lua')

local bo,ao = Vector(-60,-60,-60),Vector(60,60,60)
local up	= Vector(0,0,1)
local zero  = Vector(0,0,0)

function ENT:OnRemove()	
end

function ENT:KeyValue(key,value)
end

function ENT:Initialize()
	self:SetModel("models/devinity2/models/keitarocos/dv2_destroyer1.mdl")
	self:PhysicsInitBox(bo,ao)
	--self:SetMoveCollide(MOVECOLLIDE_FLY_SLIDE)
	--self:SetSolid(SOLID_VPHYSICS)
	self:SetCollisionGroup(COLLISION_GROUP_WEAPON)
	self:SetUseType(SIMPLE_USE)
	self.Phys = self:GetPhysicsObject()
	self.Phys:EnableMotion(false)
	self.Phys:EnableGravity(false)
	self.Phys:Sleep()
end

function ENT:OnRemove()

end

function ENT:OnTakeDamage(dmg)

end

function ENT:Use(ent)
end


function ENT:Think()
	if (IsValid(self.Player) and self.Player:Alive()) then
		local pl 	= self.Player
		if pl:KeyDown(IN_ATTACK2) then
			print("boom")
			self.storedangle = selfGetPlayer():GetAimVector()
		end
		
		if pl:KeyDown(IN_FORWARD) then
			self.Speed = math.Clamp((self.Speed || 0) + 1, -self.MaxSpeed, self.MaxSpeed)
		elseif pl:KeyDown(IN_BACK) then
			self.Speed = math.Clamp( (self.Speed || 0) - 1, -self.MaxSpeed, self.MaxSpeed)
		end
				
		if !self.storedangle then self.storedangle = self:GetAngles() end
	end
end

local ShadowParams = {
    secondstoarrive     = 1,
    maxangular             = 5000,
    maxangulardamp         = 10000,
    maxspeed             = 1000000,
    maxspeeddamp         = 10000,
    dampfactor             = 0.8,
    teleportdistance     = 200,
    deltatime             = deltatime
}

function ENT:PhysicsSimulate(phys,delta)
    phys:Wake()
    ShadowParams.pos         = self:GetPos() + self:GetForward() * ( (self.Speed || 0) *  (self.ShipSpeed || 10 ))
    ShadowParams.angle         = self.storedangle
    ShadowParams.deltatime     = delta
    
    phys:ComputeShadowControl( ShadowParams )
end

function ENT:UpdateTransmitState()
	return TRANSMIT_ALWAYS
end
