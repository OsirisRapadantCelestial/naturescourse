AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include('shared.lua')

local bo,ao = Vector(-25,-25,-25),Vector(25,25,25)
local up	= Vector(0,0,1)
local zero  = Vector(0,0,0)

function ENT:OnRemove()
end

function ENT:KeyValue(key,value)
end


local Specials = {
	[1] = "Teeth",
	[2] = "Fin",
	[3] = "Gullet",
}

function ENT:Initialize()
	
	self:SetModel("models/naturescourse/models/creature.mdl")
	self:SetCollisionGroup(COLLISION_GROUP_WEAPON)
	
	self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)
	
	self.Phys = self:GetPhysicsObject()
	self.Phys:EnableMotion(true)
	self.Phys:EnableGravity(false)
	self.Phys:Wake()
	self:StartMotionController()
end

function ENT:OnRemove()

end

function ENT:OnTakeDamage(dmg)

end

function ENT:Use(ent)
end


function ENT:Think()
	if self:GetPlayer() then
		local pl 	= self:GetPlayer()
		if !IsValid(pl) then
			self:Remove()	
		end
		
		if pl:KeyDown(IN_ATTACK2) then
			self.storedangle = pl:EyeAngles()

		end

		if pl:KeyDown(IN_ATTACK) then
			if (self.lastattack || 0 ) < CurTime() then
				self.lastattack = CurTime() + 0.5
				local pos, ang  = self:GetPos(), self:GetAngles():Forward()
				local ang = self:GetAngles()
				local pos1 = self:GetPos() - ang:Right() * 3 - ang:Up() * 4 + ang:Forward() * 20 
				local pos2  = self:GetPos() - ang:Up() * 2 + ang:Forward() * 10 + ang:Right() * 3
				 
				for index, ent in pairs(ents.FindInBox( pos1, pos2 )) do
					if string.find(ent:GetClass(), "food_") then
						if pl:CanEat( ent.foodType ) then
							local speed = 1
				
							if pl.stats["Fin"] then
								speed = ADAPTATIONS[pl.stats["Teeth"]].effects["Damage"](pl, speed)
							end
							if !speed then speed = 1 end
							ent:SetAmount(ent:GetAmount() - speed)
							pl:AddHunger(1)
							pl:AddFood(0.5)
							pl:AddDNA(math.random(1,3) )
						end
					elseif ent:GetClass() == "base_cell" and ent != self then
							local speed = 1
							if pl.stats["Fin"] then
								speed = ADAPTATIONS[pl.stats["Teeth"]].effects["Damage"](pl, speed)
							end
							if !speed then speed = 1 end
						ent:SetNewHealth(ent:GetNewHealth() - speed )
					end
				end
				
				local pos1 = self:GetPos() - ang:Right() * 3 - ang:Up() * 4 + ang:Forward() * 50 
				local pos2  = self:GetPos() - ang:Up() * 2 + ang:Forward() * 10 + ang:Right() * 3
				 
				for index, ent in pairs(ents.FindInBox( pos1, pos2 )) do
					if ent:GetClass() == "base_cell" and ent != self then
							local speed = 1
							if pl.stats["Fin"] then
								speed = ADAPTATIONS[pl.stats["Teeth"]].effects["Damage"](pl, speed)
							end
							if !speed then speed = 1 end
							pl:AddFood(0.5)
						ent:SetNewHealth(ent:GetNewHealth() - speed )
						if ent:GetNewHealth() < 1 then
							SendOutMessage( {Color(255,0,0), "[Natural Course] Player " .. ent:GetPlayer():Nick() .. " has been killed by " .. self:GetPlayer():Nick() })
						end
					end
				end
				
				for index, ent in pairs(ents.FindInSphere(self:GetPos(), 100)) do
					if ent:GetClass() == "dna_points" then
						pl:AddAdaptationSkill(ent.Adapation)
						ent:Remove()
					end
				end
			end
		end

		if self:GetNewHealth() < 1 then
			self:GetPlayer():Spectate(OBS_MODE_ROAMING)
			self:Remove()
		end
		if (self.NextSub || 0) < CurTime() then
			local speed = 1
			
			if pl.stats["Fin"] then
				speed = ADAPTATIONS[pl.stats["Fin"]].effects["Speed"](pl, speed)
			end
			
			self.SubSpeed = speed
			self.NextSub = CurTime() + 2
		end
		local speed = self.MaxSpeed + self.SubSpeed
		if pl:KeyDown(IN_FORWARD) then
			self.Speed = math.Clamp((self.Speed || 0) + 5, -speed, 200)
		elseif pl:KeyDown(IN_BACK) then
			self.Speed = math.Clamp( (self.Speed || 0) - 5, -speed, 200)
		else
			if !self.Speed then self.Speed = 0 end
			self.Speed = math.Approach(self.Speed, 0, 4)
		end

		if !self.storedangle then self.storedangle = self:GetAngles() end
	end
end

local ShadowParams = {
    secondstoarrive     = 1,
    maxangular             = 1000,
    maxangulardamp         = 10000,
    maxspeed             = 200,
    maxspeeddamp         = 10000,
    dampfactor             = 0.8,
    teleportdistance     = 200,
    deltatime             = deltatime
}

function ENT:PhysicsSimulate(phys,delta)
    phys:Wake()
    ShadowParams.pos         = self:GetPos() + self:GetForward() * ( (self.Speed || 0) *  (self.ShipSpeed || 10))
	if ShadowParams.pos.z > 8704 then
		ShadowParams.pos.z = 8704
	end
    ShadowParams.angle         = self.storedangle
    ShadowParams.deltatime     = delta

    phys:ComputeShadowControl( ShadowParams )
end

function ENT:UpdateTransmitState()
	return TRANSMIT_ALWAYS
end
