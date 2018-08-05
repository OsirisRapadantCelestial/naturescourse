function mainMenu()

    main = vgui.Create( "DPanel" )
    main:SetSize( ScrW(), ScrH() )
    main:MakePopup()

end

concommand.Add("testmain",function() mainMenu() end)
