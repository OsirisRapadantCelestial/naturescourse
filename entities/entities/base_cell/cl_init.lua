include('shared.lua')

function ENT:Draw()
	self:DrawModel()
	local start = self:GetPos()
	local endpos = self:GetPos() + self:GetAngles():Forward() * 100
	
	render.SetMaterial(Material("color") )
	render.DrawBeam( start, endpos, 20, 0, 1, Color(255,255,255))
end