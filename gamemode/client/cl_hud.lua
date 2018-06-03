hook.Add( "HUDPaint", "NShud", function()
    LocalPlayer().stats = stats || {}
end )
