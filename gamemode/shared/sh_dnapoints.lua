local plymeta = FindMetaTable( "Player" )

if SERVER then

    util.AddNetworkString( "DNA" )

    function plymeta:AddDNA( amount )
		local dnapoints = self:GetDNA()
		self:SetDNA(dnapoints + amount)
    end

    function plymeta:SetDNA( amount )
		net.Start("DNA")
			net.WriteDouble(amount)
		net.Send( self )
    end

else

    net.Receive( "DNA", function( len, pl )
		LocalPlayer().stats["DNA"] = net.ReadDouble()
    end)

end

function plymeta:GetDNA()
	return self.stats["DNA"] || 0
end
