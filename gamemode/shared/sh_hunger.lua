local plymeta = FindMetaTable( "Player" )

HUNGER_MAX = 100
HUNGER_MIN = 0

if SERVER then

    util.AddNetworkString( "Hunger" )

    function plymeta:AddHunger( amount )
		local hunger = self:GetHunger()
		self:SetHunger(hunger + amount)
    end

    function plymeta:SetHunger( amount )
		amount = math.Clamp(amount, HUNGER_MIN, HUNGER_MAX)
		self.stats["Hunger"] = amount
		net.Start("Hunger")
			net.WriteDouble(amount)
		net.Send( self )
    end

else

    net.Receive( "Hunger", function( len, pl )
        if not LocalPlayer().stats then LocalPlayer().stats = {} end
		LocalPlayer().stats["Hunger"] = net.ReadDouble()
    end)

end

function plymeta:GetHunger()
	if !self.stats then self.stats = {} end
	return self.stats["Hunger"] || 0
end
