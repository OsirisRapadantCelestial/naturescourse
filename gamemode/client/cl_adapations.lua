
function draw.SimpleTextOffest(str, txt, x,y, xalig, yalig)
	if !xalig then xalig = 0 end
	if !yalig then yalig = 0 end
	draw.SimpleText(str, txt, x+1, y+1, color_black, xalig, yalig)
	draw.SimpleText(str, txt, x, y, color_white, xalig, yalig)
end


function AdaptationsPanel()
	local pnl = vgui.Create("DFrame")
	print(ScrW()/2, ScrH()/2)
	pnl:SetSize(640-5, 360)
	pnl:Center()
	pnl:MakePopup()
	local adapations = LocalPlayer():GetAdptations()
	local slotcount = ADAPTATIONS[LocalPlayer().stats["Body"]].slots
	
	print(#slotcount)
	
	adapationsscroll = vgui.Create("DScrollPanel", pnl)
	adapationsscroll:SetSize(640/2,640/2)
	local lastpos = 0
	local x = 1
	for index, info in pairs(adapations) do
		print(info)
		PrintTable(info)
		print(index	)
		local pnl2 = vgui.Create("DPanel", adapationsscroll)
		yy = 50
		pnl2:SetSize(315, yy)
		pnl2:SetPos(0,lastpos)
		pnl2.Paint = function(self, w,h)
			
			surface.SetDrawColor(255/2,255/2,255/2)
			surface.DrawRect(0,0,w,h)
			surface.SetDrawColor(255,255,255)
			surface.DrawOutlinedRect(0,0, w,h)
			surface.SetDrawColor(0,0,0)
			surface.DrawOutlinedRect(1,1,w-2,h-2)
			draw.SimpleTextOffest("Name:"  .. info.Name, "DermaDefault", 5, 5)
		--	draw.SimpleText("Name:"  .. info.Name, "DermaDefault", 5, 5)
			surface.SetDrawColor(255,255,255)
			surface.DrawLine(0,22, w,22)
		--	surface.SetDrawColor(255/2,255/2,255/2)
			surface.SetDrawColor(0,0,0)
			surface.DrawLine(1,21, w-2,21)
			surface.DrawLine(1,23, w-2,23)
			
		end
		lastpos = lastpos + yy + 5
		x = x +1
	end
	
	slotscroll = vgui.Create("DScrollPanel", pnl)
	slotscroll:SetSize(640/2,640/2)
	slotscroll:SetPos(ScrW()/4)
	
		local pnl2 = vgui.Create("DButton", slotscroll)
		yy = 50
		pnl2:SetSize(315, yy)
		pnl2:SetPos(0,0)
		pnl2.Paint = function(self, w,h)
			surface.SetDrawColor(0,0,0)
			surface.DrawRect(0,0,w,h)
			surface.SetDrawColor(255,255,255)
			surface.DrawOutlinedRect(0,0, w,h)
			surface.SetDrawColor(255/2,255/2,255/2)
			surface.DrawOutlinedRect(1,1,w-2,h-2)
			draw.SimpleText("Body", "DermaDefault", 5, 5)
			surface.SetDrawColor(255,255,255)
			surface.DrawLine(0,22, w,22)
			surface.SetDrawColor(255/2,255/2,255/2)
			surface.DrawLine(1,21, w-2,21)
			surface.DrawLine(1,23, w-2,23)
			if false then
				draw.SimpleText("Equipped: " .. LocalPlayer().Stats[index].Name, "DermaDefault", 5, 28)
			else
				draw.SimpleText("Equipped: Nothing", "DermaDefault", 5, 28)
			end
			
		end
		pnl2:SetText("")
		pnl2.DoClick = function()
			if !SelectedItem then
				chat.AddText(color_white, "You have not selected an adaptation for your creature!")
			end
		end
	
	for index, info in pairs(slotcount) do
		local pnl2 = vgui.Create("DButton", slotscroll)
		yy = 50
		pnl2:SetSize(315, yy)
		pnl2:SetPos(0,50* (index) + 5)
		pnl2.Paint = function(self, w,h)
			surface.SetDrawColor(0,0,0)
			surface.DrawRect(0,0,w,h)
			surface.SetDrawColor(255,255,255)
			surface.DrawOutlinedRect(0,0, w,h)
			surface.SetDrawColor(255/2,255/2,255/2)
			surface.DrawOutlinedRect(1,1,w-2,h-2)
			draw.SimpleText("Slot: "  .. index, "DermaDefault", 5, 5)
			surface.SetDrawColor(255,255,255)
			surface.DrawLine(0,22, w,22)
			surface.SetDrawColor(255/2,255/2,255/2)
			surface.DrawLine(1,21, w-2,21)
			surface.DrawLine(1,23, w-2,23)
			if LocalPlayer().stats[index] then
				draw.SimpleText("Equipped: " .. LocalPlayer().Stats[index].Name, "DermaDefault", 5, 28)
			else
				draw.SimpleText("Equipped: Nothing", "DermaDefault", 5, 28)
			end
			
		end
		pnl2.DoClick = function()
			if !SelectedItem then
				chat.AddText(color_white, "You have not selected an adaptation for your creature!")
			end
		end
	end
end
concommand.Add("adapations_test", AdaptationsPanel)