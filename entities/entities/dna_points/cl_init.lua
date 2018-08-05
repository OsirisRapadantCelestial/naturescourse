include('shared.lua')

function ENT:Draw()
	self:SetAngles(Angle(0,CurTime() % 360, 0))
	self:DrawModel()
end