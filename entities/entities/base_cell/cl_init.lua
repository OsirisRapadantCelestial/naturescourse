include('shared.lua')

local Specials = {
	[1] = "Teeth",
	[2] = "Fin",
	[3] = "Gullet",
}


local teeth = Material("naturescourse/fins")
local mat2, name = CreateTexture("teethred",512,512,function(w,h)
        surface.SetDrawColor(255,255,255)
		surface.SetMaterial(teeth)
        surface.DrawTexturedRect(0,0, w,h)
    end, {
    ["$model"] = 1
    }, "VertexLitGeneric")
	
function ENT:Draw()
	
	self:SetModelScale(0.25)
	if LocalPlayer() == self:GetPlayer() then
		LocalPlayer().FakeEntity = self
	end
	
	local stats = self:GetPlayer().stats
	if !stats then
		self:DrawModel()
		return 
	end
	local body = {}
	local mat = {}
	for num, index in pairs(Specials) do
		local name =  stats[index] -- Gets the name of the model 
		if ADAPTATIONS[name] then
			for index, something in pairs(ADAPTATIONS[name].Model) do
				body[index] = something[1]
				if something[2] then
					mat[something[2][2]] = something[2][1]
				end
			end
		end
	end
	local oldtexture = {}
	local Mats = self:GetMaterials()
	for index, part in pairs(body) do
		self:SetBodygroup(index, part)
		if mat[index] then
			local PlayerMat = Material(Mats[index+1])
			oldtexture[index] = PlayerMat:GetTexture("$basetexture")
			PlayerMat:SetTexture("$basetexture",mat2:GetTexture("$basetexture"))
		end
	end
	self:DrawModel()

	for index, tex in pairs(oldtexture) do
		local PlayerMat = Material(Mats[index+1])
		PlayerMat:SetTexture("$basetexture", tex)
	end	
	
	local pos, ang  = self:GetPos(), self:GetAngles():Forward()
				local ang = self:GetAngles()
	cam.IgnoreZ(true)
	local pos1 = self:GetPos() - ang:Right() * 3
				local pos2  = self:GetPos() + ang:Up() * 5 + ang:Forward() * 5 + ang:Right() * 3
	render.DrawLine( pos1, pos2, color_white)
	
	
end
