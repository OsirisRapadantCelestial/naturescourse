
function GM:HUDPaint()
	PaintStats()
end

function PaintStats()
	PrintTable(LocalPlayer().stats)
	-- oxygen, temperature, ph, hunger, food, dnapoint
	
	local oxy = GetOxygen()
	local lvl = LocalPlayer():GetFoodLevel()
	local hung = LocalPlayer():GetHunger()
	surface.SetDrawColor(0,0,0, 200)
	surface.DrawRect(40, 40,100, 30)
	surface.DrawRect(40, 90,100, 30)
	
	surface.SetDrawColor(255,255,255)
	surface.DrawRect(40, 40, (oxy/OXYGEN_MAX )* 100, 30)
	draw.SimpleText(oxy, "DermaDefault", 90, 55, Color(255,0,0), 1, 1)
	surface.DrawRect(40, 40 + 50, (hung/HUNGER_MAX)*100, 30)
	draw.SimpleText(hung, "DermaDefault", 90, 105, Color(255,0,0), 1, 1)
	draw.SimpleText(lvl, "DermaDefault", ScrW()/2, ScrW()/2, Color(255,0,0), 1, 1)
end

function GM:CalcView( ply, pos, angles, fov)
	local view = {}
	view.pos = ply.FakeEntity:GetPos() - (ply:EyeAngles():Forward() * 100)
	view.angles = angles
	view.fov = fov
	return view
end
