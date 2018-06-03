include('shared.lua')

function ENT:Draw()
	self:DrawModel()
	local start = self:GetPos()
	local endpos = self:GetPos() + self:GetAngles():Forward() * 100
end
