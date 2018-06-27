

local meta = FindMetaTable("Player")

if SERVER then
	util.AddNetworkString("SendStats")

else
	net.Receive("SendStats", function()
		net.ReadEntity().stats = net.ReadTable()
	end)
	
end
