
/*
	This is an external Library made by TheMaw
	https://github.com/MerryMaw/gearfox/blob/master/gamemode/cl_various/texture_generator.lua
*/


local GenTex 			= {}

function CreateTexture(id,w,h,renderfunc,mat,shader)
	if (GenTex[id]) then return GenTex[id] end
	renderfunc = renderfunc or function() end
	
	local name = 'rt_'..id
	
	--create the new render target
	
	//Diffuse
	local flags = bit.bor(4, 8, 16)
	local rt = GetRenderTargetEx(name,
			w, h,
			RT_SIZE_NO_CHANGE,
			MATERIAL_RT_DEPTH_NONE,
			flags,
			CREATERENDERTARGETFLAGS_UNFILTERABLE_OK,
			IMAGE_FORMAT_DEFAULT
	)
	 
	//VMT info
	local vmt = { 
		["$basetexture"] = name,
	}
	
	mat = CreateMaterial(name, shader or 'UnlitGeneric', mat and table.Add(vmt,mat) or vmt)
	 
	--save these for later
	local oldrt = render.GetRenderTarget()
	local oldw, oldh = ScrW(), ScrH()
	 
	//Render Diffuse map!
	render.PushRenderTarget(rt)
		render.Clear(0, 0, 0, 255)
		render.ClearDepth()
		
		cam.Start2D()
			renderfunc(w,h)
		cam.End2D()
	render.PopRenderTarget()
	
	GenTex[id] = mat
	
	return GenTex[id] , name
end