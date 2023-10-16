
do -- Define SPAWN Objects
    ------------------SAM Site Template Spawners --------------------
    -- EW
    static_CV_Kuz = SPAWNSTATIC:NewFromType("STATIC_SHIP_CV_KUZNETSOV")

end

do -- define Main Menus
    menu_ASUW = MENU_MISSION:New( "Lake Mead Range")
    --menu text,   --parent menu,  --command menu function, -- command menu function arguments 

end

function simplespawn(spawn_object)
    local zone = ZONE:FindByName("LAKE_MEAD")
    local vec2 = zone:GetRandomVec2()
    local coord = COORDINATE:NewFromVec2(vec2)
    spawn_object:SpawnFromCoordinate(pnt)
end

do  -- Add spawning Options to main menus
    -- Strat SAM Spawns
        MENU_MISSION_COMMAND:New("CV Kuznetsov", menu_ASUW, simplespawn, static_CV_Kuz)
end

