do

    -- @field Nevada, fixing the field names since MOOSE is wrong as of 12/29/2021
    AIRBASE.Nevada = {
        ["Nellis_AFB"] = "Nellis",
    }
    local color_purple = {153/255,51/255,255/255}
    local color_gray = {192/255,192/255,192/255}

do -- Define Tanker Anchor Points
    COORD_tnkr_anchor_AR_230V = COORDINATE:New(-00357480, UTILS.FeetToMeters(18000), 00020272)  
    COORD_tnkr_anchor_AR_231V = COORDINATE:New(-00342829, UTILS.FeetToMeters(2500), -00162758)  -- N36, 45.00'   W116, 39.00'
    COORD_tnkr_anchor_AR_625 = COORDINATE:New(-00259371, UTILS.FeetToMeters(18000), -00266189)  -- N37, 30.00'   W117, 49.00'
    COORD_tnkr_anchor_AR_635 = COORDINATE:New(-0132119, UTILS.FeetToMeters(18000), 00048332)  -- N38, 37.00'   W114, 13.00'
    COORD_tnkr_anchor_AR_641A = COORDINATE:New(-00227374, UTILS.FeetToMeters(18000), 00080596)  -- N37, 45.00'   W113, 53.00'
end

do -- Define Tanker AUFTRAGs
    AUFTRAG_tanker_AR_230V = AUFTRAG:NewTANKER(
        COORD_tnkr_anchor_AR_230V, -- where to orbit
        20000, -- orbit altitude in ft
        250, -- orbit speed in knots
        031, -- heading
        60, -- length in nmi
        1 -- drogue system (only for AIRWING)
        )
    AUFTRAG_tanker_AR_230V:SetRadio(344.7)
    COORD_tnkr_anchor_AR_230V:LineToAll(
        COORD_tnkr_anchor_AR_230V:Translate(AUFTRAG_tanker_AR_230V.orbitLeg, AUFTRAG_tanker_AR_230V.orbitHeading),
         2, color_purple, 1, 3, true)
    COORD_tnkr_anchor_AR_230V:TextToAll("AR_230V", 2, color_purple,nil,color_gray,nil,10,true)

    AUFTRAG_tanker_AR_231V = AUFTRAG:NewTANKER(
        COORD_tnkr_anchor_AR_231V, -- where to orbit
        18000, -- orbit altitude in ft
        250, -- orbit speed in knots
        124, -- heading
        35, -- length in nmi
        1 -- drogue system (only for AIRWING)
        )
    AUFTRAG_tanker_AR_231V:SetRadio(343.6) -- NELLISAFBI11-250.pdf 20 JAN 2016

    COORD_tnkr_anchor_AR_231V:LineToAll(
        COORD_tnkr_anchor_AR_231V:Translate(AUFTRAG_tanker_AR_231V.orbitLeg, AUFTRAG_tanker_AR_231V.orbitHeading),
         2, color_purple, 1, 3, true)
    COORD_tnkr_anchor_AR_231V:TextToAll("AR_231V", 2, color_purple,nil,color_gray,nil,10,true)

    
    AUFTRAG_tanker_AR_625 = AUFTRAG:NewTANKER(
        COORD_tnkr_anchor_AR_625, -- where to orbit
        19000, -- orbit altitude in ft
        250, -- orbit speed in knots
        360, -- heading
        50, -- length in nmi
        0 -- boom system (only for AIRWING)
    )
        :SetRadio(319.800) -- NELLISAFBI11-250.pdf 20 JAN 2016
        :SetRequiredAssets(1,1)
    COORD_tnkr_anchor_AR_625:LineToAll(
        COORD_tnkr_anchor_AR_625:Translate(AUFTRAG_tanker_AR_625.orbitLeg, AUFTRAG_tanker_AR_625.orbitHeading),
         2, color_purple, 1, 3, true)
    COORD_tnkr_anchor_AR_625:TextToAll("AR_625", 2, color_purple,nil,color_gray,nil,10,true)


    AUFTRAG_tanker_AR_635 = AUFTRAG:NewTANKER(
        COORD_tnkr_anchor_AR_635, -- where to orbit
        20000, -- orbit altitude in ft
        250, -- orbit speed in knots
        272, -- heading
        50, -- length in nmi
        1 -- drogue system (only for AIRWING)
    ) 
        :SetRadio(360.800) -- NELLISAFBI11-250.pdf 20 JAN 2016
        :SetRequiredAssets(1,1)
    COORD_tnkr_anchor_AR_635:LineToAll(
        COORD_tnkr_anchor_AR_635:Translate(AUFTRAG_tanker_AR_635.orbitLeg, AUFTRAG_tanker_AR_635.orbitHeading),
         2, color_purple, 1, 3, true)
    COORD_tnkr_anchor_AR_635:TextToAll("AR_635", 2, color_purple,nil,color_gray,nil,10,true)

    AUFTRAG_tanker_AR_641A = AUFTRAG:NewTANKER(
        COORD_tnkr_anchor_AR_641A, -- where to orbit
        18000, -- orbit altitude in ft
        250, -- orbit speed in knots
        268, -- heading
        50, -- length in nmi
        1 -- drogue system (only for AIRWING)
    )
        :SetRadio(295.400) -- https://www.dreamlandresort.com/info/scanner.html
        :SetRequiredAssets(1,1)

    COORD_tnkr_anchor_AR_641A:LineToAll(
        COORD_tnkr_anchor_AR_641A:Translate(AUFTRAG_tanker_AR_641A.orbitLeg, AUFTRAG_tanker_AR_641A.orbitHeading),
         2, color_purple, 1, 3, true)
    COORD_tnkr_anchor_AR_641A:TextToAll("AR_641A", 2, color_purple,nil,color_gray,nil,10,true)


    AUFTRAG_tanker_alert = AUFTRAG:NewALERT5(AUFTRAG.Type.TANKER)
        :SetRequiredAssets(1,1)
        :SetEPLRS(false)
        :SetRepeat(99)

    AUFTRAG_tnkr_alert_F18F = AUFTRAG:NewALERT5(AUFTRAG.Type.TANKER)
        :SetRequiredAssets(1,2)
        :SetEPLRS(false)
        :SetRepeat(99)

    
end

SETOPSGROUP_Emergency_Tankers = SET_OPSGROUP:New()

do -- Emergency Tanker Misison Creator
    function msnSupport_requestEmergecyTanker(GROUP_requester)
        --local tacan_chnl = 61
        --local tacan_set = false
        --while not tacan_set
        --    for k in pairs(SETOPSGROUP_Emergency_Tankers.Set) do
        --        if k.GetTACAN()[1]==tacan_chnl break
        --   end
        local UNIT_requester = GROUP_requester:GetFirstUnitAlive()
        local COORD_requester = GROUP_requester:GetCoord()
        local COORD_nellis = AIRBASE_Nellis:GetCoord()
        local nellis_radial = COORD_nellis:GetAngleDegrees(COORD_nellis:GetDirectionVec3(COORD_requester))
        local distance = COORD_nellis:Get2DDistance(COORD_requester)/2
        local rv_cood = COORD_nellis:Translate(distance, nellis_radial)
        local emergency_tanker = AUFTRAG:NewTANKER(
            rv_cood, -- where to orbit
            18000, -- orbit altitude in ft
            280, -- orbit speed in knots
            nellis_radial, -- heading
            20, -- length in nmi
            1 -- drogue system (only for AIRWING)
        )
        emergency_tanker:SetRadio(299.000)
        emergency_tanker:SetTACAN(61,"TKR")
        emergency_tanker:SetAssetsStayAlive(true)
        emergency_tanker:SetMissionSpeed(350) -- knots
        airwing_CVW_7:AddMission(emergency_tanker)
        
        function emergency_tanker:onafterStarted(From, Event, To)
            local OPSGROUP_tnkr = self:GetOpsGroups()[1]
            SETOPSGROUP_Emergency_Tankers:AddGroup(OPSGROUP_tnkr)
            local freq = self.radio.Freq
            local callsign = OPSGROUP_tnkr:GetCallsignName()
            local rcvr_plyr_id = UNIT_requester:GetPlayerName()
            local msg_txt = rcvr_plyr_id .. ", emergency tanker deployed. Contact " ..  callsign .. " at " .. freq
            MESSAGE:New(msg_txt,15,"Information"):ToUnit(UNIT_requester)

            MSRSQ_BLACKJACK:NewTransmission(msg_txt,nil,MSRS_BLACKJACK,nil,1,{GROUP_requester},text,10)
        end

    end
end


-- Tanker callsigns
-- 1 Texaco
-- 2 Arco
-- 3 Shell
do -- define Tanker Squadrons
    sqdn_VMGR_352 = SQUADRON:New("TEMPLATE_ACFT_TNKR_KC130", 3, "VMGR-352")
    :SetGrouping(1) -- 1 in a flight
    :SetParkingIDs({206, 207, 208})
    :SetTakeoffCold()
    :SetCallsign(1, 1) -- Texaco 1
    :SetTurnoverTime(360)  -- 6 hours
    :AddMissionCapability({AUFTRAG.Type.TANKER})
    sqdn_VMGR_352_helo = SQUADRON:New("TEMPLATE_ACFT_TNKR_KC130J", 3, "VMGR-352 (Helo Support)")
    :SetGrouping(1) -- 1 in a flight
    :SetParkingIDs({206, 207, 208})
    :SetTakeoffCold()
    :SetCallsign(1, 2) -- Texaco 2
    :SetTurnoverTime(360)  -- 6 hours
    :AddMissionCapability({AUFTRAG.Type.TANKER})

    sqdn_197th_ARS = SQUADRON:New("TEMPLATE_ACFT_TNKR_KC135", 3, "197th ARS")
    :SetGrouping(1) -- 1 in a flight
    :SetParkingIDs({206, 207, 208})
    :SetTakeoffCold()
    :SetCallsign(3, 1) -- Shell 1
    :SetTurnoverTime(360)  -- 6 hours
    :AddMissionCapability({AUFTRAG.Type.TANKER, AUFTRAG.Type.ALERT5})

    sqdn_197th_ARS_mprs = SQUADRON:New("TEMPLATE_ACFT_TNKR_KC135MPRS", 3, "197th ARS (MPRS)")
        :SetGrouping(1) -- 1 in a flight
        :SetParkingIDs({206, 207, 208})
        :SetTakeoffCold()
        :SetCallsign(3, 2) -- Shell 2
        :SetTurnoverTime(360)  -- 6 hours
        :AddMissionCapability({AUFTRAG.Type.TANKER, AUFTRAG.Type.ALERT5})

    sqdn_VFA103_FA18F = SQUADRON:New("TEMPLATE_ACFT_TNKR_FA-18F", 3, "VFA-103 F/A-18F")
        :SetGrouping(1) -- 1 in a flight
        :SetParkingIDs({20,21,22,23})--({3,4,5,6,7,8,9,10,11}) 
        :SetTakeoffHot()
        :SetCallsign(2, 9) -- Arco 9
        :SetTurnoverTime(15)  -- 6 hours
        :AddMissionCapability({AUFTRAG.Type.TANKER, AUFTRAG.Type.ALERT5})
end

Refueling_Monitor = REFUELING_MONITOR:New({"197th ARS", "VMGR-352", "VFA-103 F/A-18F"})

do -- Defined Air Refueling AirWings
    airwing_161st_ARW = AIRWING:New("Warehouse Nellis-1", "161st Air Refueling Wing")
    airwing_161st_ARW:Start()
    airwing_161st_ARW:NewPayload(GROUP:FindByName("TEMPLATE_ACFT_TNKR_KC135"), -1, {AUFTRAG.Type.TANKER}, 100)
    airwing_161st_ARW:NewPayload(GROUP:FindByName("TEMPLATE_ACFT_TNKR_KC135MPRS"), -1, {AUFTRAG.Type.TANKER}, 100)
    airwing_161st_ARW:AddSquadron(sqdn_197th_ARS)
    airwing_161st_ARW:AddSquadron(sqdn_197th_ARS_mprs)
        --:AddPatrolPointAWACS(coord_awacs_anchor_BLACKJACK, 25000, 325, 35, 50)
    airwing_161st_ARW:AddMission(AUFTRAG_tanker_alert)
    --auftrag_awacs_BLACKJACK:Stop()

    airwing_MAG_11 = AIRWING:New("Warehouse Nellis-1", "Marine Aircraft Group 11")
    airwing_MAG_11:Start()
    airwing_MAG_11:NewPayload(GROUP:FindByName("TEMPLATE_ACFT_TNKR_KC130"), -1, {AUFTRAG.Type.TANKER}, 100)
    airwing_MAG_11:NewPayload(GROUP:FindByName("TEMPLATE_ACFT_TNKR_KC130J"), -1, {AUFTRAG.Type.TANKER}, 100)
    airwing_MAG_11:AddSquadron(sqdn_VMGR_352)
    airwing_MAG_11:AddSquadron(sqdn_VMGR_352_helo)

    airwing_CVW_7:NewPayload(GROUP:FindByName("TEMPLATE_ACFT_TNKR_FA-18F"), -1, {AUFTRAG.Type.TANKER}, 100)
    airwing_CVW_7:AddSquadron(sqdn_VFA103_FA18F)
    airwing_CVW_7:AddMission(AUFTRAG_tnkr_alert_F18F)

end

-- Launch Customized Tanker Mission
function launch_Tanker(AUFTRAG_tanker, UNIT_client)
    local refuelable, refuel_type = UNIT_client:IsRefuelable()
    local ops_sqdn=sqdn_197th_ARS
    local AUFTRAG_tnkr_custom = AUFTRAG_tanker
    AUFTRAG_tnkr_custom.refuelSystem=refuel_type
    AUFTRAG_tnkr_custom:SetMissionSpeed(300) -- knots
    if (UNIT_client:IsHelicopter()) then
        AUFTRAG_tnkr_custom:SetMissionAltitude(3000)
        AUFTRAG_tnkr_custom.orbitSpeed = UTILS.IasToTas(UTILS.KnotsToMps(120), AUFTRAG_tnkr_custom.orbitAltitude)
        AUFTRAG_tnkr_custom:AssignSquadrons({sqdn_VMGR_352_helo})
        airwing_AddMission(airwing_MAG_11, AUFTRAG_tnkr_custom)
        ops_sqdn=sqdn_VMGR_352_helo
    else
        AUFTRAG_tnkr_custom.orbitSpeed = UTILS.IasToTas(UTILS.KnotsToMps(270), AUFTRAG_tnkr_custom.orbitAltitude)
        airwing_AddMission(airwing_161st_ARW, AUFTRAG_tnkr_custom)
        if (refuel_type==1) then 
            ops_sqdn=sqdn_197th_ARS_mprs
        end
    end

    function AUFTRAG_tnkr_custom:OnAfterStarted(From, Event, To)
        local active_ops_groups = self:GetOpsGroups()
        local new_ops_group = active_ops_groups[#active_ops_groups]
        local new_ops_unit = new_ops_group:GetUnit()
        local ops_sqdn = new_ops_group.cohort
        local cohort_name = ops_sqdn:GetName()
        local callsign_morse = "XXX"
        local callsign = new_ops_unit:GetCallsign()
        local callsign_index = new_ops_group.callsign.NumberSquad
        local callsign_grpnum = new_ops_group.callsign.NumberGroup
        BASE:E(cohort_name .. " - " .. callsign_index .. " - " .. callsign_grpnum)

        if (callsign_index == 2) then 
            callsign_morse = "AR" .. callsign_index
            callsign = "ARCO " .. callsign_index
        elseif (callsign_index == 1) then 
            callsign_morse = "TX" .. callsign_index
            callsign = "TEX " .. callsign_index
        elseif (callsign_index == 3) then 
            callsign_morse = "SH" .. callsign_index
            callsign = "SHELL " .. callsign_index
        end
        local tacan_num = ((callsign_index + 4) * 10) + callsign_grpnum
        new_ops_group:SwitchTACAN(tacan_num, callsign_morse)
        local f10_label = "ON STATION: " .. callsign .. "-" ..  callsign_grpnum .. " - " .. self.radio.Freq .. " - TCN: " ..  tacan_num .. "Y - " .. ops_sqdn.aircrafttype--(UTILS.MetersToFeet(self.missionAltitude)/1000) .. "kft"
        local msn_coord = self:GetTargetCoordinate():Translate(math.random(UTILS.NMToMeters(3), self.orbitLeg), self.orbitHeading)  --:GetMissionWaypointCoord(self:GetOpsGroups()[1])
        local label_id = msn_coord:TextToAll(
            f10_label, 2, color_purple,nil,color_gray,nil,10,true
        )

        function self:OnAfterDone(From, Event, To)
            RemoveMark(label_id)
        end
    end
end

-- Add Group Menus
function addSubMenu_MsnSupport_Tankers(MooseGroup)
    --local menu_Support_161st_ARSacft = MENU_GROUP:New(MooseGroup, "161st Air Refueling Wing",  menus_ClientMsnSupport[MooseGroup:GetID()])
    local UNIT_client = MooseGroup:GetFirstUnitAlive()
    local refuelable, refuel_type = UNIT_client:IsRefuelable()
    local orbit_list = {
        AR_230V = AUFTRAG_tanker_AR_230V,
        AR_231V = AUFTRAG_tanker_AR_231V,
        AR_625  = AUFTRAG_tanker_AR_625,
        AR_635  = AUFTRAG_tanker_AR_635,
        AR_641A = AUFTRAG_tanker_AR_641A
    }
    if (refuelable) then 
        local menu_Support_tankers = MENU_GROUP:New(MooseGroup, "Tankers",  menus_ClientMsnSupport[MooseGroup:GetID()])
        --if (refuel_type==1) then 
        --    for key, AUFTRAG_tanker in pairs(orbit_list) do

        --        MENU_GROUP:New(MooseGroup, key, launch_Tanker, AUFTRAG_tanker, MooseGroup)
        --    end
        --else
            for key,value in pairs(orbit_list) do
                local AUFTRAG_tanker=value
                MENU_GROUP_COMMAND:New(MooseGroup, key, menu_Support_tankers, launch_Tanker, AUFTRAG_tanker, UNIT_client)
            end
            MENU_GROUP_COMMAND:New(MooseGroup, "Emergency Tanker", menu_Support_tankers, msnSupport_requestEmergecyTanker, MooseGroup)
        end

end

end