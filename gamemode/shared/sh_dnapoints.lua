local plymeta = FindMetaTable( "Player" )

if SERVER then

    util.AddNetworkString( "DNA" )

    function plymeta:AddDNA( amount )
		local dnapoints = self:GetDNA()
		self:SetDNA(dnapoints + amount)
    end

    function plymeta:SetDNA( amount )
		self.stats["DNA"] = amount
		net.Start("DNA")
			net.WriteDouble(amount)
		net.Send( self )
    end

	
	function plymeta:GetPermaAdpataion()
		return self.permaadap || nil
	end
	
	function plymeta:AddPermaAdpataion(num)
		self.permaadap = (self.permaadap || 0) + num
	end
	
	
else

    net.Receive( "DNA", function( len, pl )
        if not LocalPlayer().stats then LocalPlayer().stats = {} end
		LocalPlayer().stats["DNA"] = net.ReadDouble()
    end)

end

function plymeta:GetDNA()
	return self.stats["DNA"] || 0
end
