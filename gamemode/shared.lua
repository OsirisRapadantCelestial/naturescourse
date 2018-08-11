GM.Name = "Nature's Course"
GM.Author = "Anthony Fuller, Star, Hawk"
GM.Email = "N/A"
GM.Website = "N/A"

function GM:Initialize()

end

function GM:PlayerFootstep(ply)
	return true
end

local auto = {}

local function ExecuteOnFolder(dir, recursive, func)
    local path = GM.Folder:gsub("gamemodes/","") .. "/gamemode/"
    local fpath = table.concat({path,dir,"/*"})
    local files, directories = file.Find(fpath,"LUA")
    for k,v in pairs(files) do
        if string.GetExtensionFromFilename(v) ~= "lua" then continue end
        local callpath = table.concat({path,dir,"/",v})
        func(callpath)
    end
    if recursive then
        for k,v in pairs(directories) do
            local npath = table.concat({dir,"/",v})
            ExecuteOnFolder(npath,true,func)
        end
    end
end

auto.AddLuaCSFolder = function(dir,recursive)
    ExecuteOnFolder(dir,recursive,function(f)
        if SERVER then AddCSLuaFile(f)
        else include(f) end
    end)
end

auto.AddLuaSVFolder = function(dir,recursive)
    if CLIENT then return end
    ExecuteOnFolder(dir,recursive,function(f)
        include(f)
    end)
end

auto.AddLuaSHFolder = function(dir,recursive)
    ExecuteOnFolder(dir,recursive,function(f)
        if SERVER then AddCSLuaFile(f) end
        include(f)
    end)
end
auto.AddLuaSHFolder("libraries",true)
auto.AddLuaCSFolder("client",true)
auto.AddLuaSVFolder("server",true)
auto.AddLuaSHFolder("shared",true)

ADAPTATIONS = {}
DEFAULTCELL = {}
ADAPTATIONTBL = {}
function RegisterAdaptation(tbl)
	ADAPTATIONS[tbl.Name] = tbl
	ADAPTATIONTBL[#ADAPTATIONTBL + 1] = tbl.Name
	if tbl.Default then
		DEFAULTCELL[tbl.type] = tbl.Name
	end
end


function GetRandomAdaptation()
	return table.Random(ADAPTATIONTBL)
end

auto.AddLuaSHFolder("adaptations",true)
