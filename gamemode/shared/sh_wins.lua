local plymeta = FindMetaTable( "Player" )

if SERVER then

    util.AddNetworkString( "Wins" )

    function plymeta:AddWin( amount )
		local win = self:GetWins()
		self:SetWins(win + amount)
    end

    function plymeta:SetWins( amount )
		self.wins = amount
		net.Start("Wins")
			net.WriteDouble(amount)
		net.Send( self )
    end

else

    net.Receive( "Wins", function( len, pl )
		local ent = net.ReadEntity()
        if not ent.wins then ent.wins = 0 end
		ent.wins = net.ReadDouble()
    end)

end

function plymeta:GetWins()
	if !self.wins then self.wins = 0 end
	return self.wins || 0
end
