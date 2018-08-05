local plymeta = FindMetaTable( "Player" )

if SERVER then

    util.AddNetworkString( "Losses" )

    function plymeta:AddLoss( amount )
		local losses = self:GetWins()
		self:SetLosses(losses + amount)
    end

    function plymeta:SetLosses( amount )
		self.losses = amount
		net.Start("Losses")
			net.WriteEntity(self)
			net.WriteDouble(amount)
		net.Broadcast()
    end

else

    net.Receive( "Losses", function( len, pl )
		local ent = net.ReadEntity()
        if not ent.losses then ent.losses = 0 end
		ent.losses = net.ReadDouble()
    end)

end

function plymeta:GetLosses()
	if !self.losses then self.losses = 0 end
	return self.losses || 0
end
