
if SERVER then
	util.AddNetworkString("send_event_msg")
	
	
	function SendOutMessage(msg)
		net.Start("send_event_msg")
			net.WriteTable(msg)
		net.Broadcast()
	end
	
else
	net.Receive("send_event_msg", function()
		chat.AddText(unpack(net.ReadTable()))
	end)
end
