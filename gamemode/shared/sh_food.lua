local plymeta = FindMetaTable( "Player" )

if SERVER then

    util.AddNetworkString( "Food" )

    function plymeta:AddFood( amount )
		local food = self:GetFood()
		self:SetFood(food + amount)
    end

    function plymeta:SetFood( amount )
		self.stats["Food"] = amount
		net.Start("Food")
			net.WriteDouble(amount)
		net.Send( self )
    end

else

    net.Receive( "Food", function( len, pl )
        if not LocalPlayer().stats then LocalPlayer().stats = {} end
		LocalPlayer().stats["Food"] = net.ReadDouble()
    end)

end

function plymeta:GetFood()
	if !self.stats then self.stats = {} end
	return self.stats["Food"] || 0
end

function plymeta:GetFoodLevel()
	local num = self:GetFood()
	local val = (2)^2
	local x = 0
	while val <= num do
		x = x + 1
		val = (x+2)^2
	end
	
	return x, val, (x+1)^2
end