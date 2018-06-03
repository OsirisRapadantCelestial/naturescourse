include('shared.lua')

function ENT:Draw()
	self:DrawModel()
	if LocalPlayer() == self:GetPlayer() then
		LocalPlayer().FakeEntity = self
	end
end
