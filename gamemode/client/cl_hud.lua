
function GM:HUDPaint()
	PaintStats()
end

local icon = Material("target.png", "smooth noclamp")

function PaintStats()
	-- oxygen, temperature, ph, hunger, food, dnapoint

	local oxy = GetOxygen()
	local lvl, nextlevel, lastlevel = LocalPlayer():GetFoodLevel()
	local food = LocalPlayer():GetFood()
	local hung = LocalPlayer():GetHunger()
	surface.SetDrawColor(0,0,0, 200)
	surface.DrawRect(40, 40,100, 30)
	surface.DrawRect(40, 90,100, 30)
	surface.DrawRect(40, 90 + 50,100, 30)
	surface.SetDrawColor(255,255,255)
	if IsValid(LocalPlayer().FakeEntity) then
	surface.DrawRect(40, 40, (LocalPlayer().FakeEntity:GetNewHealth()/100)* 100, 30)
	draw.SimpleText("Health: " ..LocalPlayer().FakeEntity:GetNewHealth(), "DermaDefault", 90, 55, Color(255,0,0), 1, 1)
	end
	surface.DrawRect(40, 40 + 50, (hung/HUNGER_MAX)*100, 30)
	draw.SimpleText("Food: " .. hung, "DermaDefault", 90, 105, Color(255,0,0), 1, 1)

	surface.DrawRect(40, 40 + 100, ((food-lastlevel)/(nextlevel-lastlevel) )*100, 30)
	draw.SimpleText("Level: " .. lvl, "DermaDefault", 90, 155, Color(255,0,0), 1, 1)

	
	surface.SetDrawColor(0,0,0, 200)
	local str = "HOW TO PLAY\n\n\nCONTROLS\n\n\nW = Forward\nS = Backwards\nRight Click = Turn\nLeft Click = Pickup / Attack"
	surface.DrawRect(ScrW()/2 - 106, 40,210, 50)
	draw.SimpleText("AIM OF GAME", "DermaDefault", ScrW()/2, 40, color_white, 1, 0)
	draw.SimpleText("There are two goals to this game!", "DermaDefault", ScrW()/2, 60, color_white, 1, 0)
	draw.SimpleText("Eat the most food or be the last to survive!", "DermaDefault", ScrW()/2, 75, color_white, 1, 0)
	
	surface.DrawRect(38, ScrH()/2 +40,137, 120)
	draw.SimpleText("HOW TO PLAY", "DermaDefault" , 70, ScrH()/2 + 40)
	draw.SimpleText("W = Forward", "DermaDefault" , 40, ScrH()/2 + 60)
	draw.SimpleText("S = Backwards", "DermaDefault" , 40, ScrH()/2 + 80)
	draw.SimpleText("Right Click = Turn", "DermaDefault" , 40, ScrH()/2 + 100)
	draw.SimpleText("Left Click = Pickup / Attack", "DermaDefault" , 40, ScrH()/2 + 120)
	draw.SimpleText("Q = Open Adaptation Panel", "DermaDefault" , 40, ScrH()/2 + 140)
	-- \n\n\nW = Forward\nS = Backwards\nRight Click = Turn\nLeft Click = Pickup / Attack"
	
	for index, ent in pairs(ents.FindByClass("food_meat"))  do
		local tbl = ent:GetPos():ToScreen()
		if tbl.visible then
			surface.SetDrawColor(255, 0, 0)
			surface.SetMaterial(icon)
			surface.DrawTexturedRect(tbl.x-15, tbl.y-15, 30, 30)
		end
	end

	for index, ent in pairs(ents.FindByClass("food_plant"))  do
		local tbl = ent:GetPos():ToScreen()
		if tbl.visible then
			surface.SetDrawColor(0, 255, 0)
			surface.SetMaterial(icon)
			surface.DrawTexturedRect(tbl.x-15, tbl.y-15, 30, 30)
		end
	end

	for index, ent in pairs(ents.FindByClass("dna_points"))  do
		local tbl = ent:GetPos():ToScreen()
		if tbl.visible then
			surface.SetDrawColor(255, 255, 255)
			surface.SetMaterial(icon)
			surface.DrawTexturedRect(tbl.x-15, tbl.y-15, 30, 30)
		end
	end
	
	for index, ent in pairs(ents.FindByClass("base_cell")) do
		local tbl = ent:GetPos():ToScreen()
		if tbl.visible then
			surface.SetDrawColor(255, 255, 255)
			surface.SetMaterial(icon)
			surface.DrawTexturedRect(tbl.x-15, tbl.y-15, 30, 30)
		end
		draw.SimpleText(ent:GetPlayer():Name() ..": " .. ent:GetNewHealth(), "DermaDefault", tbl.x, tbl.y, color_white, 1,1)
	end
	
end

function GM:CalcView( ply, pos, angles, fov)

	if IsValid(ply.FakeEntity) then
	local view = {}

	view.origin = ply.FakeEntity:GetPos()-( angles:Forward()*100 )
	view.angles = angles
	view.fov = fov
	view.drawviewer = true

	return view
	end
end
