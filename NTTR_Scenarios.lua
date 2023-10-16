do -- Define Scenario Menu & Other GLOBALS
    menu_Scenarios = MENU_COALITION:New(coalition.side.BLUE, "Scenarios")

    COORD_Tonopah_Test = AIRBASE_Tonopah_Test:GetCoordinate()
end -- Scenario Menu

do -- Simple Op Start function for menus
    function OperationStart(operation)
        operation:Start()
    end
end

do -- Simple Next Phase function for menus
    function OperationNextPhase(operation)
        operation:SetPhaseStatus(operation:GetPhaseActive(), OPERATION.PhaseStatus.OVER)
    end
end

do -- Define Island Assault Operation

    op_RED_FLAG_ISL_ASSLT = OPERATION:New("RED FLAG: Island Assault")
    op_RED_FLAG_ISL_ASSLT:AddPhase("Phase 1: Stage Forces")
    op_RED_FLAG_ISL_ASSLT:AddPhase("Phase 2: Start Assault")

    local COORD_IslAssault_Island = COORDINATE:New(-00236780,0,-00085274)
    local isl_outpost = SPAWNSTATIC:NewFromType("VP-ARZ")
    local zone_ad_tonopah_stat_ne = ZONE:FindByName("SAM_SITE_TONOPAH_TEST_STRAT_NE")
    
    local coord_Staging_Area = COORD_IslAssault_Island:Translate(UTILS.NMToMeters(20), 280)
    local coord_Landing_Beach = COORD_IslAssault_Island:Translate(UTILS.NMToMeters(2.5), 280)
    local ZONE_Landing_Beach = ZONE_RADIUS:New("Landing_Beach", coord_Landing_Beach, UTILS.NMToMeters(.20))

    local auftrag_HoldBeach = AUFTRAG:NewARMOREDGUARD(coord_Landing_Beach:Translate(300, 100))
    local lcacs_landed = 0

    local SPAWN_AssaultForce_LCACs = SPAWN:NewWithAlias("TEMPLATE_GND_LCAC", "AssaultForces-LCAC-")
    SPAWN_AssaultForce_LCACs:InitRandomizeUnits(true, 200, 400)
    SPAWN_AssaultForce_LCACs:InitLimit(0,0)
    local asslt_force_templates = {"TEMPLATE_GND_INF_MECH_SQDN_ZBD-04A", "TEMPLATE_GND_INF_MECH_SQDN_ZBD-04A", "TEMPLATE_GND_INF_MECH_SQDN_ZBD-04A", "TEMPLATE_SAM_HQ-7_BATTALION", "TEMPLATE_MANPAD_SA-24_SQUAD-1" }
    local SPAWN_AssaultForce_IFV = SPAWN:NewWithAlias("TEMPLATE_GND_INF_MECH_SQDN_ZBD-04A", "AssaultForces-IFV-")
    SPAWN_AssaultForce_IFV:OnSpawnGroup(
        function(SpawnGroup)
            local arty_msn = AUFTRAG:NewARTY(COORD_IslAssault_Island, 100)
            local ops_group = OPSGROUP:New(SpawnGroup)
            ops_group:AddMission(arty_msn)
        end
    ) 
    local SPAWN_AssaultForce_HQ7 = SPAWN:NewWithAlias("TEMPLATE_SAM_HQ-7_BATTALION", "AssaultForces-SHORAD-")
    local SPAWN_AssaultForce_SA24 = SPAWN:NewWithAlias("TEMPLATE_MANPAD_SA-24_SQUAD-1", "AssaultForces-MANPAD-")
    local zone_island_cap = ZONE_RADIUS:New("CAP_Island_Assault", COORD_IslAssault_Island:GetVec2(), UTILS.NMToMeters(20))
    local zone_island_cas = ZONE_RADIUS:New("CAP_Island_Assault", COORD_IslAssault_Island:GetVec2(), UTILS.NMToMeters(2))
    local cap_island_n = AUFTRAG:NewCAP(zone_island_cap, 20000, 350, COORD_IslAssault_Island:Translate(UTILS.NMToMeters(35), 315), 20)
    local cap_island_s = AUFTRAG:NewCAP(zone_island_cap, 20000, 350, COORD_IslAssault_Island:Translate(UTILS.NMToMeters(35), 240), 20)
    cas_island = AUFTRAG:NewCAS(zone_island_cas, 500, 100):SetDuration(45*60):AssignSquadrons({tbl_NAWDC_Sqdns.Mi24P})

    auftrag_AttackIsl = AUFTRAG:NewPATROLZONE(zone_island_cas)


    local SETGROUP_AssaultForces = SET_GROUP:New()

    function disembarkLCAC(lcac_group)
        lcac_group:E("At waypoint!")
        local COORD_disembark = lcac_group:GetCoordinate()
        if (COORD_disembark:Get2DDistance(COORD_IslAssault_Island) < UTILS.NMToMeters(3)) then
            lcac_group:E("Disembarking!")
            lcacs_landed = lcacs_landed + 1



            if (lcacs_landed > 6) then
                SETGROUP_isl_assault_ops_assault_forces = SET_GROUP:New()
                SETGROUP_isl_assault_ops_assault_forces:FilterPrefixes("AssaultForces-IFV-")
                SETGROUP_isl_assault_ops_assault_forces:ForEachGroup( 
                    ---     @param Wrapper.Group#GROUP MooseGroup
                    function( MooseGroup ) 
                        --if (MooseGroup:GetSpeedMax() > 0) then 
                        MooseGroup:RouteGroundTo(COORD_IslAssault_Island)
                        --end
                        local OPSGROUP_assault = OPSGROUP:New(MooseGroup)
                        OPSGROUP_assault:AddMission(AUFTRAG:NewARMORATTACK(isl_outpost))
                    end 
                )
            end

            if (lcacs_landed % 3 == 0) then
                SPAWN_AssaultForce_HQ7:SpawnFromCoordinate(COORD_disembark:Translate(100, lcac_group:GetHeading()))
                SETGROUP_AssaultForces:Add(SPAWN_AssaultForce_HQ7:GetLastAliveGroup())
                SPAWN_AssaultForce_SA24:SpawnFromCoordinate(COORD_disembark:Translate(100, lcac_group:GetHeading()))
                SETGROUP_AssaultForces:Add(SPAWN_AssaultForce_SA24:GetLastAliveGroup())
            else
                SPAWN_AssaultForce_IFV:SpawnFromCoordinate(COORD_disembark:Translate(100, lcac_group:GetHeading()))
                SETGROUP_AssaultForces:Add(SPAWN_AssaultForce_IFV:GetLastAliveGroup())
                SPAWN_AssaultForce_IFV:SpawnFromCoordinate(COORD_disembark:Translate(100, lcac_group:GetHeading()))
                SETGROUP_AssaultForces:Add(SPAWN_AssaultForce_IFV:GetLastAliveGroup())
                SPAWN_AssaultForce_IFV:SpawnFromCoordinate(COORD_disembark:Translate(100, lcac_group:GetHeading()))
                SETGROUP_AssaultForces:Add(SPAWN_AssaultForce_IFV:GetLastAliveGroup())
                SPAWN_AssaultForce_IFV:SpawnFromCoordinate(COORD_disembark:Translate(100, lcac_group:GetHeading()))
                SETGROUP_AssaultForces:Add(SPAWN_AssaultForce_IFV:GetLastAliveGroup())
            end
        end
    end
    SPAWN_AssaultForce_LCACs:OnSpawnGroup(
        function(SpawnGroup)
            local COORD_mylanding = COORD_IslAssault_Island:Translate(UTILS.NMToMeters(2.5), math.random(270, 260))
            SpawnGroup:RouteGroundTo(COORD_mylanding, UTILS.MpsToKmph(UTILS.MiphToMps( 60 )), ENUMS.Formation.Vehicle.EchelonRight, nil, disembarkLCAC, SpawnGroup)
        end                    
    )
    function op_RED_FLAG_ISL_ASSLT:OnAfterPhaseChange(From, Event, To, Phase)

        local current_phase = op_RED_FLAG_ISL_ASSLT:GetPhaseActive()

        if current_phase == op_RED_FLAG_ISL_ASSLT:GetPhaseByName("Phase 1: Stage Forces") then
            -- Spawn Island Outpost Statics
            local static_isl_outpost = isl_outpost:SpawnFromCoordinate(COORD_IslAssault_Island)

            -- Spawn Island Outpost Ground Units
            local spawn_isl_assault_ops_island_defenses = SPAWN:NewWithAlias("TEMPLATE_GND_COMPANY_MOTORINFANTRY_NATO", "IslandDefenses-")
            spawn_isl_assault_ops_island_defenses:InitRandomizePosition(true, UTILS.NMToMeters(.2), UTILS.NMToMeters(.05))
            spawn_isl_assault_ops_island_defenses:SpawnFromCoordinate(COORD_IslAssault_Island)
            spawn_isl_assault_ops_island_defenses:InitRandomizeTemplatePrefixes("TEMPLATE_MANPAD_STINGER_SQUAD")
            spawn_isl_assault_ops_island_defenses:SpawnFromCoordinate(COORD_IslAssault_Island)
            spawn_isl_assault_ops_island_defenses:SpawnFromCoordinate(COORD_IslAssault_Island)
            spawn_isl_assault_ops_island_defenses:SpawnFromCoordinate(COORD_IslAssault_Island)
                            
            SETGROUP_isl_assault_ops_island_defenses = SET_GROUP:FilterPrefixes("IslandDefenses-")
            op_RED_FLAG_ISL_ASSLT:E("Island Defenses Spawned")


            -- Launch Standard AWACS
            airwing_NAWDC:AddMission(AUFTRAG_r_awacs_nawdc)
            op_RED_FLAG_ISL_ASSLT:E("Red AWACS Launched")


            -- Define Phase I Missions

            zone_tonopah_test = ZONE_RADIUS:New("CAP_Tonopah_Test", COORD_Tonopah_Test:GetVec2(), UTILS.NMToMeters(20))
            AUFTRAG_islAssault_hover = AUFTRAG:NewORBIT(COORD_IslAssault_Island:Translate(UTILS.NMToMeters(30), 270), 6000, 100)
            AUFTRAG_islAssault_hover:SetRequiredAssets(4)
            AUFTRAG_islAssault_hover:AssignSquadrons({tbl_NAWDC_Sqdns.Mi24P})

            AUFTRAG_islAssault_ftrOrbit_n = AUFTRAG:NewORBIT(COORD_Tonopah_Test:Translate(UTILS.NMToMeters(20), 315), 24000)
            AUFTRAG_islAssault_ftrOrbit_n:SetRequiredAssets(2)
            AUFTRAG_islAssault_ftrOrbit_n:AssignSquadrons({tbl_NAWDC_Sqdns.J11A})
            AUFTRAG_islAssault_ftrOrbit_s = AUFTRAG:NewORBIT(COORD_Tonopah_Test:Translate(UTILS.NMToMeters(20), 225), 24000)
            AUFTRAG_islAssault_ftrOrbit_s:SetRequiredAssets(2)
            AUFTRAG_islAssault_ftrOrbit_s:AssignSquadrons({tbl_NAWDC_Sqdns.J11A})


            -- Spawn Tonopah Test Air Defenses
            local isl_assault_ops_air_defenses = SPAWN:NewWithAlias("TEMPLATE_SAM_SA-20A_BATTALION", "OpAsset_IslDef_AD-")
            isl_assault_ops_air_defenses:SpawnInZone(zone_ad_tonopah_stat_ne)
            airwing_NAWDC:AddMission(AUFTRAG_islAssault_hover)
            --airwing_NAWDC:AddMission(trooptransport_alert)
            airwing_NAWDC:AddMission(AUFTRAG_islAssault_ftrOrbit_n)
            airwing_NAWDC:AddMission(AUFTRAG_islAssault_ftrOrbit_s)


            -- Spawn Assault Forces

            SPAWN_AssaultForce_LCACs:SpawnFromCoordinate(coord_Landing_Beach:Translate(UTILS.NMToMeters(3), 274))
            SPAWN_AssaultForce_LCACs:SpawnFromCoordinate(coord_Landing_Beach:Translate(UTILS.NMToMeters(3), 276))
            SPAWN_AssaultForce_LCACs:SpawnFromCoordinate(coord_Landing_Beach:Translate(UTILS.NMToMeters(3), 278))
            SPAWN_AssaultForce_LCACs:SpawnFromCoordinate(coord_Landing_Beach:Translate(UTILS.NMToMeters(3), 280))

            menu_Scenarios_Isl_Asslt_Stage:Remove()
            menu_Scenarios_Isl_Asslt_Start = MENU_COALITION_COMMAND:New(coalition.side.BLUE, "Start", menu_Scenarios_Isl_Asslt, OperationNextPhase, op_RED_FLAG_ISL_ASSLT)
        elseif current_phase == op_RED_FLAG_ISL_ASSLT:GetPhaseByName("Phase 2: Start Assault") then
            op_RED_FLAG_ISL_ASSLT:E("Launching Phase 2 Missions")
            -- Define Phase II Missions

            SETGROUP_islAssault_fighters_N = SET_GROUP:New()
            SETGROUP_islAssault_fighters_S = SET_GROUP:New()
            SETGROUP_islAssault_helos = SET_GROUP:New()

            for OpGroupID, OpGroupData in pairs( AUFTRAG_islAssault_ftrOrbit_n:GetOpsGroups() ) do
                SETGROUP_islAssault_fighters_N:AddGroup(OpGroupData:GetGroup())
            end
            for OpGroupID, OpGroupData in pairs( AUFTRAG_islAssault_ftrOrbit_s:GetOpsGroups() ) do
                SETGROUP_islAssault_fighters_S:AddGroup(OpGroupData:GetGroup())
            end
            for OpGroupID, OpGroupData in pairs( AUFTRAG_islAssault_hover:GetOpsGroups() ) do
                SETGROUP_islAssault_helos:AddGroup(OpGroupData:GetGroup())
            end
            SETGROUP_islAssault_fighters_N:ForEachGroup(
                function(group)
                    local flt_grp = FLIGHTGROUP:New(group)
                    local curr_mission = flt_grp:GetMissionCurrent()
                    --function cap_island_n:OnAfterStarted(From, Event, To)
                    --    flt_grp:MissionCancel(curr_mission)
                    --end
                    flt_grp:AddMission(cap_island_n)
                    flt_grp:MissionCancel(curr_mission)

                end
            )
            SETGROUP_islAssault_fighters_S:ForEachGroup(
                function(group)
                    local flt_grp = FLIGHTGROUP:New(group)
                    local curr_mission = flt_grp:GetMissionCurrent()
                    --function cap_island_s:OnAfterStarted(From, Event, To)
                    --    flt_grp:MissionCancel(curr_mission)
                    --end
                    flt_grp:AddMission(cap_island_s)
                    flt_grp:MissionCancel(curr_mission)

                end
            )
            SETGROUP_islAssault_helos:ForEachGroup(
                function(group)
                    local flt_grp = FLIGHTGROUP:New(group)
                    local curr_mission = flt_grp:GetMissionCurrent()
                    -- cas_island:OnAfterStarted(From, Event, To)
                    --    flt_grp:MissionCancel(curr_mission)
                    --end
                    flt_grp:AddMission(cas_island)
                    flt_grp:MissionCancel(curr_mission)

                end
            )

            local function spawn_lcacs() 
                SPAWN_AssaultForce_LCACs:SpawnFromCoordinate(coord_Staging_Area)
                SPAWN_AssaultForce_LCACs:SpawnFromCoordinate(coord_Staging_Area)
                SPAWN_AssaultForce_LCACs:SpawnFromCoordinate(coord_Staging_Area)
                SPAWN_AssaultForce_LCACs:SpawnFromCoordinate(coord_Staging_Area) 
            end
            SPAWN_AssaultForce_LCACs:ScheduleRepeat(
                10, 60 * 10, 0,
                60 * 10 * 2,
                spawn_lcacs
            )

            --for index, group in pairs(cap:GetOpsGroups()) do
            --    local fltGroup = FLIGHTGROUP:New(group:GetGroup())
            --    op_RED_FLAG_ISL_ASSLT:E(group:"")
            --    cap_island:SetDuration(45*60)
            --    group:AddMission( cap_island_n)
            --    --cap:SetDuration(0)
            --    group:MissionCancel(cap)
            --end
            --for index, group in pairs(cas_alert:GetOpsGroups()) do
            --    group:AddMission(auftrag_AttackIsl)
            --    group:MissionStart(auftrag_AttackIsl)
            --    group:MissionCancel(cas_alert)
            --end

        end
    end
    menu_Scenarios_Isl_Asslt = MENU_COALITION:New(coalition.side.BLUE, "Island Assault", menu_Scenarios)
    menu_Scenarios_Isl_Asslt_Stage = MENU_COALITION_COMMAND:New(coalition.side.BLUE, "Stage", menu_Scenarios_Isl_Asslt, OperationStart, op_RED_FLAG_ISL_ASSLT)

end --Island Assault Operation

do -- Define PLANAF Bomber Strike Operation
    op_PLANAF_STRIKE = OPERATION:New("RED FLAG: PLANAF Strike")
    op_PLANAF_STRIKE:AddPhase("Phase 1: Stage Forces")
    op_PLANAF_STRIKE:AddPhase("Phase 2: Start Strike")
    op_PLANAF_STRIKE:AddPhase("Phase 3: End Strike")
    SPAWNSTATIC_cvn73 = SPAWNSTATIC:NewFromType("CVN_73")
    SPAWN_h6_4xyj12 = SPAWN:NewWithAlias("TEMPLATE_ACFT_BMBR_H-6_ASUW_YJ-12", "OP-PLANAF_Stk_H6_YJ12"):InitRandomizePosition(true, UTILS.NMToMeters(5))
    SPAWN_h6_6xyj83 = SPAWN:NewWithAlias("TEMPLATE_ACFT_BMBR_H-6_ASUW_YJ-83K", "OP-PLANAF_Stk_H6_YJ83"):InitRandomizePosition(true, UTILS.NMToMeters(5))
    SPAWN_j10_4xPL12_2xPL8 = SPAWN:NewWithAlias("TEMPLATE_ACFT_FTR_J-10A_BVR_2SHIP", "OP-PLANAF_Stk_J10_Escort"):InitRandomizePosition(true, UTILS.NMToMeters(5))
    SPAWN_j10_sweep = SPAWN:NewWithAlias("TEMPLATE_ACFT_FTR_J-10A_BVR_2SHIP", "OP-PLANAF_Stk_J10_Sweep"):InitRandomizePosition(true, UTILS.NMToMeters(5))
    COORD_static_cvn73 = AIRBASE_Lincoln:GetCoordinate():Translate(UTILS.NMToMeters(5), 270)
    COORD_pkg_spawn = COORD_static_cvn73:Translate(UTILS.NMToMeters(250), 285):SetAltitude(UTILS.FeetToMeters(30000))
    SETGROUP_h6_4xyj12 = SET_GROUP:New()
    SETGROUP_h6_6xyj83 = SET_GROUP:New()
    SETGROUP_j10_escort = SET_GROUP:New()
    SETGROUP_j10_sweep = SET_GROUP:New()

    function op_PLANAF_STRIKE:OnAfterPhaseChange(From, Event, To, Phase)

        local current_phase = op_PLANAF_STRIKE:GetPhaseActive()
        local primary_attack_radial = 285
        if current_phase == op_PLANAF_STRIKE:GetPhaseByName("Phase 1: Stage Forces") then
            AUFTRAG_bmbr_orbit = AUFTRAG:NewORBIT(COORD_pkg_spawn, 30000)
            COORD_static_cvn73 = AIRBASE_Lincoln:GetCoordinate():Translate(UTILS.NMToMeters(5), 270)
            STATIC_cvn73 = SPAWNSTATIC_cvn73:SpawnFromCoordinate(COORD_static_cvn73, 0, "OP-PLANAF_Stk_Static_CVN73")
            SPAWN_h6_4xyj12:OnSpawnGroup(
                function(SpawnGroup)
                    SETGROUP_h6_4xyj12:AddGroup(SpawnGroup)
                   local bmbr_grp = FLIGHTGROUP:New(SpawnGroup)
                    bmbr_grp:AddMission(AUFTRAG_bmbr_orbit)
                    SPAWN_j10_4xPL12_2xPL8:OnSpawnGroup(
                        function(FtrGroup)
                            SETGROUP_j10_escort:AddGroup(FtrGroup)
                            J10FltGroup = FLIGHTGROUP:New(FtrGroup)
                            --AUFTRAG_ftr_escort = AUFTRAG:NewESCORT(SpawnGroup, {x = -100, y = 0, z = -18000})
                            AUFTRAG_ftr_escort = AUFTRAG:NewESCORT(SpawnGroup, {x = 10000, y = 0, z = 0})
                            AUFTRAG_ftr_escort:SetMissionEgressCoord(COORD_pkg_spawn)
                            AUFTRAG_ftr_escort:SetFormation(ENUMS.Formation.FixedWing.LineAbreast.Group)
                            J10FltGroup:AddMission(AUFTRAG_ftr_escort)
                        end
                    )
                    SPAWN_j10_4xPL12_2xPL8:SpawnFromCoordinate(COORD_pkg_spawn)
                    --SPAWN_j10_4xPL12_2xPL8:OnSpawnGroup(
                    --    function(FtrGroup)
                    --        SETGROUP_j10_escort:AddGroup(FtrGroup)
                    --        J10FltGroup = FLIGHTGROUP:New(FtrGroup)
                    --        J10FltGroup:SetDefaultFormation(ENUMS.Formation.FixedWing.Spread.Open)
                    --        AUFTRAG_ftr_escort = AUFTRAG:NewESCORT(SpawnGroup, {x = -100, y = 0, z = 18000})
                    --        AUFTRAG_ftr_escort:SetMissionEgressCoord(COORD_pkg_spawn)
                    --        AUFTRAG_ftr_escort:SetFormation(ENUMS.Formation.FixedWing.LineAbreast.Group)
                    --        J10FltGroup:AddMission(AUFTRAG_ftr_escort)
                    --    end
                    --)
                    --SPAWN_j10_4xPL12_2xPL8:SpawnFromCoordinate(COORD_pkg_spawn)
                end 
            )
            SPAWN_h6_6xyj83:OnSpawnGroup(
                function(SpawnGroup)
                   SETGROUP_h6_6xyj83:AddGroup(SpawnGroup)
                   local bmbr_grp = FLIGHTGROUP:New(SpawnGroup)
                   bmbr_grp:AddMission(AUFTRAG_bmbr_orbit)
                   SPAWN_j10_4xPL12_2xPL8:OnSpawnGroup(
                        function(FtrGroup)
                            SETGROUP_j10_escort:AddGroup(FtrGroup)
                            J10FltGroup = FLIGHTGROUP:New(FtrGroup)
                            --AUFTRAG_ftr_escort = AUFTRAG:NewESCORT(SpawnGroup, {x = -100, y = 0, z = -18000})
                            AUFTRAG_ftr_escort = AUFTRAG:NewESCORT(SpawnGroup, {x = 10000, y = 0, z = 0})
                            AUFTRAG_ftr_escort:SetMissionEgressCoord(COORD_pkg_spawn)
                            AUFTRAG_ftr_escort:SetFormation(ENUMS.Formation.FixedWing.LineAbreast.Group)
                            J10FltGroup:AddMission(AUFTRAG_ftr_escort)
                        end
                    )
                    SPAWN_j10_4xPL12_2xPL8:SpawnFromCoordinate(COORD_pkg_spawn)
                    --SPAWN_j10_4xPL12_2xPL8:OnSpawnGroup(
                    --    function(FtrGroup)
                    --        SETGROUP_j10_escort:AddGroup(FtrGroup)
                    --        J10FltGroup = FLIGHTGROUP:New(FtrGroup)
                    --        AUFTRAG_ftr_escort = AUFTRAG:NewESCORT(SpawnGroup, {x = -100, y = 0, z = 18000})
                    --        AUFTRAG_ftr_escort:SetMissionEgressCoord(COORD_pkg_spawn)
                    --        J10FltGroup:AddMission(AUFTRAG_ftr_escort)
                    --    end
                    --)
                    --SPAWN_j10_4xPL12_2xPL8:SpawnFromCoordinate(COORD_pkg_spawn)
                end 
            )
            SPAWN_j10_sweep:OnSpawnGroup(
                function(FtrGroup)
                    SETGROUP_j10_sweep:AddGroup(FtrGroup)
                    J10FltGroup = FLIGHTGROUP:New(FtrGroup)
                    J10FltGroup:AddMission(AUFTRAG_bmbr_orbit)
                end
            )

            SCHEDULER:New( nil, 
                function()
                    SPAWN_h6_6xyj83:SpawnFromCoordinate(COORD_pkg_spawn)
                end, {}, 
                5,  -- do this in 5 sec
                30, -- repeat 30 sec later,
                0, -- no randomization
                45 -- stop after 45
            )
            SCHEDULER:New( nil, 
                function()
                    SPAWN_h6_4xyj12:SpawnFromCoordinate(COORD_pkg_spawn)
                end, {}, 
                60,  -- do this in 60 sec
                30, -- repeat 30 sec later,
                0, -- no randomization
                45 -- stop after 45
            )
            SCHEDULER:New( nil, 
                function()
                    SPAWN_j10_sweep:SpawnFromCoordinate(COORD_pkg_spawn)
                end, {}, 
                120,  -- do this in 120 sec
                30, -- repeat 30 sec later,
                0, -- no randomization
                45 -- stop after 45
            )
            collectgarbage()
            --SPAWN_h6_6xyj83:SpawnFromCoordinate(COORD_pkg_spawn)
            --SPAWN_h6_6xyj83:SpawnFromCoordinate(COORD_pkg_spawn)
            --SPAWN_h6_4xyj12:SpawnFromCoordinate(COORD_pkg_spawn)
            --SPAWN_h6_4xyj12:SpawnFromCoordinate(COORD_pkg_spawn)

            --SPAWN_j10_sweep:SpawnFromCoordinate(COORD_pkg_spawn)
            --SPAWN_j10_sweep:SpawnFromCoordinate(COORD_pkg_spawn)

            MENU_Scenarios_PLANAF_StkPkg_Stage:Remove()
            MENU_Scenarios_PLANAF_StkPkg_Start = MENU_COALITION_COMMAND:New(coalition.side.BLUE, "Start", MENU_Scenarios_PLANAF_StkPkg, OperationNextPhase, op_PLANAF_STRIKE)

        elseif current_phase == op_PLANAF_STRIKE:GetPhaseByName("Phase 2: Start Strike") then
            index = 1
            SETGROUP_h6_6xyj83:ForEachGroup(
                function (group)
                    BASE:E(group.GroupName .. "tasked with strike mission")
                   local bmbr_grp = FLIGHTGROUP:New(group)
                   local msn = AUFTRAG:NewBAI(STATIC_cvn73, 22000)
                   local atk_radial = primary_attack_radial
                   if index%2==0 then
                    atk_radial = atk_radial + 15
                   else
                    atk_radial = atk_radial - 15
                   end
                   msn:SetFormation(ENUMS.Formation.FixedWing.Trail.Open)
                   msn:SetMissionSpeed(450)
                   msn:SetMissionEgressCoord(COORD_pkg_spawn)
                   msn:SetWeaponExpend(AI.Task.WeaponExpend.ALL)
                   msn:SetPriority(1, true)
                   msn:SetTime(index * 3 * 60)
                   msn:SetMissionWaypointCoord(COORD_static_cvn73:Translate(UTILS.NMToMeters(70), atk_radial))
                   local curr_mission = bmbr_grp:GetMissionCurrent()
                   bmbr_grp:AddMission(msn)
                   function msn:OnAfterStarted(From, Event, To)
                    bmbr_grp:MissionCancel(curr_mission)
                   end
                   --function bmbr_grp:onafterPassingWaypoint(From, Event, To, Waypoint)
                   --     if (bmbr_grp:HasPassedFinalWaypoint()) then
                   --         bmbr_grp:Destroy()
                   --     end
                   -- end
                   --curr_mission:Cancel()   
                   --bmbr_grp:MissionStart(msn)   
                   index = index + 1 
                end
            )
            SETGROUP_h6_4xyj12:ForEachGroup(
                function (group)
                    BASE:E(group.GroupName .. "tasked with strike mission")
                   local bmbr_grp = FLIGHTGROUP:New(group)
                   local msn = AUFTRAG:NewBAI(STATIC_cvn73, 30000)
                   local atk_radial = primary_attack_radial
                   if index%2==0 then
                    atk_radial = atk_radial + 8
                   else
                    atk_radial = atk_radial - 8
                   end
                   msn:SetFormation(ENUMS.Formation.FixedWing.Trail.Open)
                   msn:SetMissionSpeed(450)
                   msn:SetMissionEgressCoord(COORD_pkg_spawn)
                   msn:SetWeaponExpend(AI.Task.WeaponExpend.ALL)
                   msn:SetPriority(1, true)
                   msn:SetTime(index * 3 * 60)
                   msn:SetMissionWaypointCoord(COORD_static_cvn73:Translate(UTILS.NMToMeters(120), atk_radial))
                   local curr_mission = bmbr_grp:GetMissionCurrent()
                   bmbr_grp:AddMission(msn)
                   function msn:OnAfterStarted(From, Event, To)
                    bmbr_grp:MissionCancel(curr_mission)
                   end
                   --function bmbr_grp:onafterPassingWaypoint(From, Event, To, Waypoint)
                   --     if (bmbr_grp:HasPassedFinalWaypoint()) then
                   --         bmbr_grp:Destroy()
                   ---     end
                   -- end
                   --curr_mission:Cancel()   
                   --bmbr_grp:MissionStart(msn)  
                   index = index + 1
                end
            )
            ZONE_PLANAF_Strike_Sweep = ZONE_RADIUS:New(
                "PLANAF_Strike_Sweep_N", 
                COORD_static_cvn73:Translate(UTILS.NMToMeters(35), 280):GetVec2(), 
                UTILS.NMToMeters(65)
            )
            AUFTRAG_sweep_n = AUFTRAG:NewCAP(
                ZONE_PLANAF_Strike_Sweep,
                24000, 475,
                COORD_static_cvn73:Translate(UTILS.NMToMeters(105), 300),
                120, 20
            )
            AUFTRAG_sweep_n:SetMissionSpeed(500)
            AUFTRAG_sweep_n:SetMissionEgressCoord(COORD_pkg_spawn)
            AUFTRAG_sweep_n:SetPriority(1, true)
            AUFTRAG_sweep_n:SetDuration(30*60)
            AUFTRAG_sweep_s = AUFTRAG:NewCAP(
                ZONE_PLANAF_Strike_Sweep,
                24000, 475,
                COORD_static_cvn73:Translate(UTILS.NMToMeters(90), 260),
                80, 20
            )
            AUFTRAG_sweep_s:SetMissionSpeed(500)
            AUFTRAG_sweep_s:SetMissionEgressCoord(COORD_pkg_spawn)
            AUFTRAG_sweep_s:SetPriority(1, true)
            AUFTRAG_sweep_s:SetDuration(30*60)
            sweep = 1
            SETGROUP_j10_sweep:ForEachGroup(
                function (group)
                   local sweeper_grp = FLIGHTGROUP:New(group)
                   local curr_mission = sweeper_grp:GetMissionCurrent()
                   if (sweep == 1) then
                      BASE:E(group.GroupName .. "tasked with north sweep mission")
                      sweeper_grp:AddMission(AUFTRAG_sweep_n)
                      sweeper_grp:MissionCancel(curr_mission)
                      --curr_mission:Cancel()   
                      --sweeper_grp:MissionStart(AUFTRAG_sweep_n)    
                      sweep = 2
                    else
                      BASE:E(group.GroupName .. "tasked with south sweep mission")
                      sweeper_grp:AddMission(AUFTRAG_sweep_s)
                      sweeper_grp:MissionCancel(curr_mission)
                      --curr_mission:Cancel()   
                      --sweeper_grp:MissionStart(AUFTRAG_sweep_s)    
                      sweep = 1
                   end
                   --function sweeper_grp:onafterPassingWaypoint(From, Event, To, Waypoint)
                   --     if (sweeper_grp:HasPassedFinalWaypoint()) then
                   --         sweeper_grp:Destroy()
                   --     end
                   -- end    
                end
            ) 
            MENU_Scenarios_PLANAF_StkPkg_Start:Remove()
            MENU_Scenarios_PLANAF_StkPkg_End = MENU_COALITION_COMMAND:New(coalition.side.BLUE, "End", MENU_Scenarios_PLANAF_StkPkg, OperationNextPhase, op_PLANAF_STRIKE)
        elseif current_phase == op_PLANAF_STRIKE:GetPhaseByName("Phase 3: End Strike") then
            SETGROUP_j10_sweep:ForEachGroup(
                function (group)
                    group:Destroy()
                end
            )
            SETGROUP_j10_escort:ForEachGroup(
                function (group)
                    group:Destroy()
                end
            )
            SETGROUP_h6_4xyj12:ForEachGroup(
                function (group)
                    group:Destroy()
                end
            )
            SETGROUP_h6_6xyj83:ForEachGroup(
                function (group)
                    group:Destroy()
                end
            )
            op_PLANAF_STRIKE:Over()
            MENU_Scenarios_PLANAF_StkPkg_End:Remove()
            MENU_Scenarios_PLANAF_StkPkg_Stage = MENU_COALITION_COMMAND:New(coalition.side.BLUE, "Stage", MENU_Scenarios_PLANAF_StkPkg, OperationStart, op_PLANAF_STRIKE)

        end
    end
    MENU_Scenarios_PLANAF_StkPkg = MENU_COALITION:New(coalition.side.BLUE, "PLANAF Strike", menu_Scenarios)
    MENU_Scenarios_PLANAF_StkPkg_Stage = MENU_COALITION_COMMAND:New(coalition.side.BLUE, "Stage", MENU_Scenarios_PLANAF_StkPkg, OperationStart, op_PLANAF_STRIKE)
end

do -- Define Long Range Strike Operation
    
    op_RED_FLAG_LR_ASUW = OPERATION:New("RED FLAG: Long Range ASUW Strike")
    op_RED_FLAG_LR_ASUW:AddPhase("Phase 1: Stage Forces")
    op_RED_FLAG_LR_ASUW:AddPhase("Phase 2: Launch Strike Package")
    op_RED_FLAG_LR_ASUW:AddPhase("Phase 3: End Strike")

    MENU_Scenarios_LR_ASUW = MENU_COALITION:New(coalition.side.BLUE, "Long-Range ASUW Strike", menu_Scenarios)
    MENU_Scenarios_LR_ASUW_Stage = MENU_COALITION_COMMAND:New(coalition.side.BLUE, "Stage", MENU_Scenarios_LR_ASUW, OperationStart, op_RED_FLAG_LR_ASUW)

    SPAWNSTATIC_cv = SPAWNSTATIC:NewFromType("CV_1143_5"):InitCountry(country.id.AGGRESSORS)
    COORD_cv = COORD_Tonopah_Test:Translate(UTILS.NMToMeters(1.378), 74)
    SPAWNSTATIC_luyang = SPAWNSTATIC:NewFromType("Type_052B"):InitCountry(country.id.AGGRESSORS)
    SPAWNSTATIC_jiangkai = SPAWNSTATIC:NewFromType("Type_054A"):InitCountry(country.id.AGGRESSORS)
    IADS_PLAN_SAG = SkynetIADS:create("IADS_PLANAF_SAG")

    function op_RED_FLAG_LR_ASUW:OnAfterPhaseChange(From, Event, To, Phase)
        current_phase = op_RED_FLAG_LR_ASUW:GetPhaseActive()

        if current_phase == op_RED_FLAG_LR_ASUW:GetPhaseByName("Phase 1: Stage Forces") then

            local formation_heading = 157
            STATIC_cv = SPAWNSTATIC_cv:SpawnFromCoordinate(COORD_cv, formation_heading, "OP-LR_Stk_Static_CV")
            STATIC_ddg1 = SPAWNSTATIC_luyang:SpawnFromCoordinate(
                COORD_cv:Translate(UTILS.NMToMeters(5), 120), formation_heading, "OP-LR_Stk_Static_Luyang-1")
            STATIC_ddg2 = SPAWNSTATIC_luyang:SpawnFromCoordinate(
                COORD_cv:Translate(UTILS.NMToMeters(3.39), 23), formation_heading, "OP-LR_Stk_Static_Luyang-2")
            STATIC_ddg3 = SPAWNSTATIC_luyang:SpawnFromCoordinate(
                COORD_cv:Translate(UTILS.NMToMeters(5), 300), formation_heading, "OP-LR_Stk_Static_Luyang-3")
            STATIC_ffg1 = SPAWNSTATIC_jiangkai:SpawnFromCoordinate(
                COORD_cv:Translate(UTILS.NMToMeters(5), 180), formation_heading, "OP-LR_Stk_Static_Jiangkai-1")
            SPAWN_op_lr_asuw_sa22 = SPAWN:NewWithAlias("TEMPLATE_SAM_SA-22_BATTALION", "OP-LR_Stk_SA22-")
                :InitLimit(0,0)
                :InitAIOn()
                :InitGroupHeading(formation_heading-90)
            
            SPAWN_op_lr_asuw_sa20 = SPAWN:NewWithAlias("TEMPLATE_SAM_SA-20A_BATTALION", "OP-LR_Stk_SA20A-")
                :InitLimit(0,0)
                :InitAIOn()
                :InitGroupHeading(formation_heading-90)
                :OnSpawnGroup(
                function( SpawnGroup )
                    local sa_20_name = SpawnGroup.GroupName
                        IADS_PLAN_SAG:addSAMSite(sa_20_name):setActAsEW(true)
                        IADS_PLAN_SAG:activate()
                        SPAWN_op_lr_asuw_sa22:SpawnFromCoordinate(SpawnGroup:GetCoordinate():Translate(-100, formation_heading))

                    end
                )

            SPAWN_op_lr_asuw_sa22:OnSpawnGroup(
                function(SpawnGroup)
                    local i = SPAWN_op_lr_asuw_sa22:GetSpawnIndexFromGroup(SpawnGroup)
                    local GROUP_sa_20 = SPAWN_op_lr_asuw_sa20:GetGroupFromIndex(i)
                    IADS_PLAN_SAG:getSAMSiteByGroupName(GROUP_sa_20.GroupName):addPointDefense(SpawnGroup.GroupName) 
                end
            )

            SPAWN_op_lr_asuw_sa20:SpawnFromCoordinate(STATIC_ddg1:GetCoordinate():Translate(250, formation_heading-30))
            SPAWN_op_lr_asuw_sa20:SpawnFromCoordinate(STATIC_ddg2:GetCoordinate():Translate(250, formation_heading-30))
            SPAWN_op_lr_asuw_sa20:SpawnFromCoordinate(STATIC_ddg3:GetCoordinate():Translate(250, formation_heading-30))


            AUFTRAG_op_lr_asuw_alert5 = AUFTRAG:NewALERT5(AUFTRAG.Type.CAP):SetRequiredAssets(1,2):AssignSquadrons({tbl_NAWDC_Sqdns.J11A})
            airwing_NAWDC:AddMission(AUFTRAG_op_lr_asuw_alert5)

            
            AUFTRAG_Op_LR_Strike_bmbr_orbit_B52 = AUFTRAG:NewORBIT(AIRBASE_Lincoln:GetCoordinate():Translate(UTILS.NMToMeters(100), 40), 40000)
            AUFTRAG_Op_LR_Strike_bmbr_orbit_B52:AssignSquadrons({sqdn_96th_BOMB_SQDN}):SetRequiredAssets(1,2)
            AUFTRAG_Op_LR_Strike_bmbr_orbit_B52:SetTeleport(false)
            airwing_2nd_BW:AddMission(AUFTRAG_Op_LR_Strike_bmbr_orbit_B52)

            AUFTRAG_Op_LR_Strike_bmbr_orbit_B2 = AUFTRAG:NewORBIT(AIRBASE_Lincoln:GetCoordinate():Translate(UTILS.NMToMeters(100), 40), 40000)
            AUFTRAG_Op_LR_Strike_bmbr_orbit_B2:AssignSquadrons({sqdn_13th_BOMB_SQDN}):SetRequiredAssets(1,2)
            --AUFTRAG_Op_LR_Strike_bmbr_orbit_B2:SetTeleport(false)
            --airwing_509th_BW:AddMission(AUFTRAG_Op_LR_Strike_bmbr_orbit_B2)

            AUFTRAG_Op_LR_Strike_ELINT = AUFTRAG:NewORBIT(AIRBASE_Lincoln:GetCoordinate():Translate(UTILS.NMToMeters(10), 120), 28000, 350, 350, 60)
                :SetTime(60 * 10)
                :SetTeleport(false)
            function AUFTRAG_Op_LR_Strike_ELINT:OnAfterExecuting(From, Event, To)
                local ops_group = AUFTRAG_Op_LR_Strike_ELINT:GetOpsGroups()[1]
                local unit = ops_group:GetUnit(1)
                HOUND_blue:addPlatform(unit:Name())
            end
            airwing_55th_RW:AddMission(AUFTRAG_Op_LR_Strike_ELINT)

            AUFTRAG_Op_LR_Strike_jammer_hold_N = AUFTRAG:NewORBIT(AIRBASE_Lincoln:GetCoordinate():Translate(UTILS.NMToMeters(50), 45), 26000)

            AUFTRAG_Op_LR_Strike_jammer_hold_S = AUFTRAG:NewORBIT(AIRBASE_Lincoln:GetCoordinate():Translate(UTILS.NMToMeters(40), 100), 26000)
            AUFTRAG_Op_LR_Strike_jammer_hold_N:AssignSquadrons({SQDN_VAQ_141}):SetRequiredAssets(1,1):SetTime(60 * 12):SetTeleport(false)
            AUFTRAG_Op_LR_Strike_jammer_hold_S:AssignSquadrons({SQDN_VAQ_141}):SetRequiredAssets(1,1):SetTime(60 * 12):SetTeleport(false)
            airwing_CVW_7:AddMission(AUFTRAG_Op_LR_Strike_jammer_hold_N)
            airwing_CVW_7:AddMission(AUFTRAG_Op_LR_Strike_jammer_hold_S)


            AUFTRAG_tanker_buddy1 = AUFTRAG:NewTANKER(
                AIRBASE_Lincoln:GetCoordinate():Translate(UTILS.NMToMeters(800), 100), -- where to orbit
                22000, -- orbit altitude in ft
                350, -- orbit speed in knots
                360, -- heading
                50, -- length in nmi
                1 -- drogue system (only for AIRWING)
                )
                :SetRadio(294.100)
                :SetRequiredAssets(1,1)
                :SetTACAN(51, "BDY1")
                :SetPriority(100)
                :SetTime(60 * 20)
            AUFTRAG_tanker_buddy2 = AUFTRAG_tanker_buddy1
            AUFTRAG_tanker_buddy2:SetMissionWaypointCoord(AIRBASE_Lincoln:GetCoordinate():Translate(UTILS.NMToMeters(90), 95))
            AUFTRAG_tanker_buddy2:SetRadio(294.300)
                :SetTACAN(53, "BDY2")

            AUFTRAG_tanker_buddy3 = AUFTRAG_tanker_buddy1
            AUFTRAG_tanker_buddy3:SetMissionWaypointCoord(AIRBASE_Lincoln:GetCoordinate():Translate(UTILS.NMToMeters(100), 90))
            AUFTRAG_tanker_buddy3:SetRadio(294.500)
                :SetTACAN(55, "BDY2")
            
            airwing_CVW_7:AddMission(AUFTRAG_tanker_buddy1)
            airwing_CVW_7:AddMission(AUFTRAG_tanker_buddy2)
            airwing_CVW_7:AddMission(AUFTRAG_tanker_buddy3)

                MENU_Scenarios_LR_ASUW_Stage:Remove()
                MENU_Scenarios_LR_ASUW_Start = MENU_COALITION_COMMAND:New(coalition.side.BLUE, "Start", MENU_Scenarios_LR_ASUW, OperationNextPhase, op_RED_FLAG_LR_ASUW)
        elseif current_phase == op_RED_FLAG_LR_ASUW:GetPhaseByName("Phase 2: Launch Strike Package") then
            op_RED_FLAG_LR_ASUW:E("Launching Phase 2 Missions")

            --[[function AUFTRAG_Op_LR_Strike_ELINT:onafterStop(From, Event, To)
                local op_group = AUFTRAG_Op_LR_Strike_ELINT:GetOpsGroups()[1]
                local flt_grp = FLIGHTGROUP:New(op_group.group)
                local elint_support = AUFTRAG:NewORBIT(AIRBASE_Lincoln:GetCoordinate():Translate(UTILS.NMToMeters(30), 240), 28000, 350, 350, 60)
                flt_grp:AddMission(elint_support)
                flt_grp:MissionCancel(flt_grp:GetMissionCurrent())
            end
            AUFTRAG_Op_LR_Strike_ELINT:Cancel()
            ]]--
            SETGROUP_Op_LRStrike_r_ftrs = SET_GROUP:New()

            AUFTRAG_Op_LR_Strike_ELINT:SetMissionWaypointCoord(AIRBASE_Lincoln:GetCoordinate():Translate(UTILS.NMToMeters(20), 220))

            for OpGroupID, OpGroupData in pairs( AUFTRAG_op_lr_asuw_alert5:GetOpsGroups() ) do
                SETGROUP_Op_LRStrike_r_ftrs:AddGroup(OpGroupData:GetGroup())
            end
            SETGROUP_Op_LRStrike_r_ftrs:ForEachGroup(
                function(group)
                    BASE:E(group.GroupName .. "tasked with cap mission")
                    local flt_grp = FLIGHTGROUP:New(group)
                    local curr_mission = flt_grp:GetMissionCurrent()
                    local ZONE_defended_region = ZONE_RADIUS:New("Op_LR_Strike_R_CAP", STATIC_cv:GetCoordinate():GetVec2(), UTILS.NMToMeters(100))
                    local cap_r_cv = AUFTRAG:NewCAP(ZONE_defended_region, 20000, 350, STATIC_cv:GetCoordinate())

                    flt_grp:AddMission(cap_r_cv)
                    flt_grp:MissionCancel(curr_mission)

                end
            )
            
            SETGROUP_Op_LRStrike_jammers = SET_GROUP:New()
            for OpGroupID, OpGroupData in pairs( AUFTRAG_Op_LR_Strike_jammer_hold_N:GetOpsGroups() ) do
                SETGROUP_Op_LRStrike_jammers:AddGroup(OpGroupData:GetGroup())
            end
            for OpGroupID, OpGroupData in pairs( AUFTRAG_Op_LR_Strike_jammer_hold_S:GetOpsGroups() ) do
                SETGROUP_Op_LRStrike_jammers:AddGroup(OpGroupData:GetGroup())
            end
            AUFTRAG_Op_LR_Strike_jammer_jam_N = AUFTRAG:NewORBIT(STATIC_cv:GetCoordinate():Translate(UTILS.NMToMeters(70), 30), 26000, 240, 20):SetTime(60*10)
            AUFTRAG_Op_LR_Strike_jammer_jam_S = AUFTRAG:NewORBIT(STATIC_cv:GetCoordinate():Translate(UTILS.NMToMeters(70), 90), 26000, 300, 20):SetTime(60*10)

            function AUFTRAG_Op_LR_Strike_jammer_jam_N:onafterStarted(From, Event, To)
                local OPSGROUP_grwlr = self:GetOpsGroups()[1]
                --local freq = self.radio.Freq
                --local callsign = OPSGROUP_grwlr:GetCallsignName()
                --local msg_txt = "Growler deployed. Contact " ..  callsign .. " at " .. freq
                --if (GROUP_requester ~= nil) then
                --    local UNIT_requester = GROUP_requester:GetFirstUnitAlive()
                --    local rcvr_plyr_id = UNIT_requester:GetPlayerName()
                --    msg_txt = rcvr_plyr_id .. ", " .. msg_txt
                --   MESSAGE:New(msg_txt,15,"Information"):ToUnit(UNIT_requester)
                --end
                --MSRSQ_BLACKJACK:NewTransmission(msg_txt,nil,MSRS_BLACKJACK,nil,1,nil,nil,nil)
                local jammerSource = OPSGROUP_grwlr:GetDCSUnit(1)
                jammer_n = SkynetIADSJammer:create(jammerSource, IADS_PLAN_SAG)
                function self:onafterExecuting(From, Event, To)
                    local OPSGROUP_grwlr = self:GetOpsGroups()[1]
                    jammer_n:MasterArmOn()
                end
                function self:onafterDone(From, Event, To)
                    jammer_n:MasterArmSafe()
                end
            end
            function AUFTRAG_Op_LR_Strike_jammer_jam_S:onafterStarted(From, Event, To)
                local OPSGROUP_grwlr = self:GetOpsGroups()[1]
                --local freq = self.radio.Freq
                --local callsign = OPSGROUP_grwlr:GetCallsignName()
                --local msg_txt = "Growler deployed. Contact " ..  callsign .. " at " .. freq
                --if (GROUP_requester ~= nil) then
                --    local UNIT_requester = GROUP_requester:GetFirstUnitAlive()
                --    local rcvr_plyr_id = UNIT_requester:GetPlayerName()
                --    msg_txt = rcvr_plyr_id .. ", " .. msg_txt
                --   MESSAGE:New(msg_txt,15,"Information"):ToUnit(UNIT_requester)
                --end
                --MSRSQ_BLACKJACK:NewTransmission(msg_txt,nil,MSRS_BLACKJACK,nil,1,nil,nil,nil)
                local jammerSource = OPSGROUP_grwlr:GetDCSUnit(1)
                jammer_s = SkynetIADSJammer:create(jammerSource, IADS_PLAN_SAG)
                function self:onafterExecuting(From, Event, To)
                    local OPSGROUP_grwlr = self:GetOpsGroups()[1]
                    jammer_s:MasterArmOn()
                end
                function self:onafterDone(From, Event, To)
                    jammer_s:MasterArmSafe()
                end
            end
            index = 1
            SETGROUP_Op_LRStrike_jammers:ForEachGroup(
                function(group)
                    BASE:E(group.GroupName .. "tasked with cap mission")
                    local flt_grp = FLIGHTGROUP:New(group)
                    local curr_mission = flt_grp:GetMissionCurrent()
                    if (index == 1) then
                        flt_grp:AddMission(AUFTRAG_Op_LR_Strike_jammer_jam_S)
                    else
                        flt_grp:AddMission(AUFTRAG_Op_LR_Strike_jammer_jam_N)
                    end
                    flt_grp:MissionCancel(curr_mission)
                    index = index + 1
                end
            )





            SETGROUP_Op_LR_Strike_bmbrs = SET_GROUP:New()

            --for OpGroupID, OpGroupData in pairs( AUFTRAG_Op_LR_Strike_bmbr_orbit_B2:GetOpsGroups() ) do
            --    if OpGroupData ~= nil then SETGROUP_Op_LR_Strike_bmbrs:AddGroup(OpGroupData:GetGroup()) end
            --end
            for OpGroupID, OpGroupData in pairs( AUFTRAG_Op_LR_Strike_bmbr_orbit_B52:GetOpsGroups() ) do
                if OpGroupData ~= nil  then SETGROUP_Op_LR_Strike_bmbrs:AddGroup(OpGroupData:GetGroup()) end
            end
            index = 1
            SETGROUP_Op_LR_Strike_bmbrs:ForEachGroup(
                function(group)
                    BASE:E(group.GroupName .. "tasked with strike mission")
                    local flt_grp = FLIGHTGROUP:New(group)
                    local curr_mission = flt_grp:GetMissionCurrent()
                    --function cap_island_n:OnAfterStarted(From, Event, To)
                    --    flt_grp:MissionCancel(curr_mission)
                    --end
                    if (index > SPAWN_op_lr_asuw_sa20:_GetLastIndex()) then index = 1 end
                    local tgt = SPAWN_op_lr_asuw_sa20:GetGroupFromIndex(index)
                    local stk_msn = AUFTRAG:NewBAI(tgt, 30000)
                    local ip_coord = STATIC_cv:GetCoordinate():Translate(UTILS.NMToMeters(85), 60)
                    ip_coord:SetAltitude(UTILS.FeetToMeters(30000))
                    stk_msn:SetWeaponExpend(AI.Task.WeaponExpend.ALL)
                        --:SetTeleport(false)
                        --:SetGroupWaypointCoordinate(ip_coord)
                        :SetMissionWaypointCoord(ip_coord)
                        :SetEngageAltitude(30000)
                        :SetMissionSpeed(450)
                    flt_grp:AddMission(stk_msn)
                    flt_grp:MissionCancel(curr_mission)
                    index = index + 1
                end
            )
            

            MENU_Scenarios_LR_ASUW_Start:Remove()
            MENU_Scenarios_LR_ASUW_End = MENU_COALITION_COMMAND:New(coalition.side.BLUE, "End", MENU_Scenarios_LR_ASUW, OperationNextPhase, op_RED_FLAG_LR_ASUW)
        end
    end


end --Island Assault Operation