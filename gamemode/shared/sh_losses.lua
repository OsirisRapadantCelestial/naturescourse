local plymeta = FindMetaTable( "Player" )

if SERVER then

    util.AddNetworkString( "Losses" )

    function plymeta:AddLoss( amount )
		local losses = self:GetWins()
		self:SetWins(losses + amount)
    end

    function plymeta:SetLosses( amount )
		self.losses = amount
		net.Start("Losses")
			net.WriteDouble(amount)
		net.Send( self )
    end

else

    net.Receive( "Losses", function( len, pl )
        if not LocalPlayer().losses then LocalPlayer().losses = 0 end
		LocalPlayer().losses = net.ReadDouble()
    end)

end

function plymeta:GetLosses()
	if !self.losses then self.losses = 0 end
	return self.losses || 0
end
