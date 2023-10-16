do

    -- @field Nevada, fixing the field names since MOOSE is wrong as of 12/29/2021
    AIRBASE.Nevada = {
        ["Nellis_AFB"] = "Nellis",
    }

do -- Define AWACS Anchor Points
    COORD_awacs_anchor_NE = COORDINATE:New(-00243025, UTILS.FeetToMeters(25000), 00050108)
    COORD_awacs_anchor_SE = COORDINATE:New(-00330541, UTILS.FeetToMeters(25000), 00036340)  -- N36, 50.00'   W114, 25.0'
    COORD_awacs_anchor_SW = COORDINATE:New(-00381023, UTILS.FeetToMeters(25000), -00131058)
end


do -- Define AWACS AUFTRAGs
    AUFTRAG_awacs_NE = AUFTRAG:NewAWACS(
        COORD_awacs_anchor_NE, -- where to orbit
        25000, -- orbit altitude in ft
        400, -- orbit speed in knots
        360, -- heading
        30 -- length in nmi
    )
    :SetRadio(237.6)
    :SetRequiredAssets(1,1)

    AUFTRAG_awacs_SE = AUFTRAG:NewAWACS(
        COORD_awacs_anchor_SE, -- where to orbit
        25000, -- orbit altitude in ft
        400, -- orbit speed in knots
        30, -- heading
        30 -- length in nmi
    )
    :SetRadio(255.7)
    :SetRequiredAssets(1,1)
    
    AUFTRAG_awacs_SW = AUFTRAG:NewAWACS(
        COORD_awacs_anchor_SE, -- where to orbit
        25000, -- orbit altitude in ft
        400, -- orbit speed in knots
        290, -- heading
        30 -- length in nmi
    )
    :SetRadio(267.6)
    :SetRequiredAssets(1,1)

end
do -- 552nd Air Control Wing
    airwing_552nd_ACW = AIRWING:New("Warehouse Nellis-1", "552nd Air Control Wing")
    airwing_552nd_ACW:Start()
    airwing_552nd_ACW:NewPayload(GROUP:FindByName("TEMPLATE_ACFT_AWACS_E-3A"), -1, {AUFTRAG.Type.AWACS}, 100)
        --:AddPatrolPointAWACS(COORD_awacs_anchor_BLACKJACK, 25000, 325, 35, 50)
    airwing_552nd_ACW:AddMission(AUFTRAG:NewALERT5(AUFTRAG.Type.AWACS):SetRequiredAssets(1,1))
    --- Function called each time a flight group is send on a mission.
    function airwing_552nd_ACW:OnAfterFlightOnMission(From, Event, To, FlightGroup, Mission)
        local flightgroup=FlightGroup --Ops.FlightGroup#FLIGHTGROUP
        local mission=Mission --Ops.Auftrag#AUFTRAG
        if (mission:GetType() == AUFTRAG.Type.AWACS) then
            local AUFTRAG_escortAwacs = AUFTRAG:NewESCORT(flightgroup:GetGroup()):SetTime(300)
            airwing_57th_WG:AddMission(AUFTRAG_escortAwacs)
            --BLACKJACK:AddMission(AUFTRAG_escortAwacs)
            --TIMER:New(airwing_57th_WG.AddMission, self, AUFTRAG_escortAwacs):Start(120)
            --TIMER:New(airwing_57th_WG.AddMission, AUFTRAG_escortAwacs):Start(120)

        end

        --- Function called when the flight group gets low on fuel (default < 25% fuel remaining). 
        function flightgroup:OnAfterFuelLow(From, Event, To)
            local text=string.format("Running low on fuel %.2f. Returning to base!", flightgroup:GetFuelMin())
            env.info(string.format("FF %s: %s", flightgroup:GetName(), text))
            MESSAGE:New(text, 120, flightgroup:GetName()):ToAll()
        end
    end
end
-- AWACS Callsign Enumerators
-- 1 Overlord
-- 2 Magic
-- 3 Wizard
-- 4 Focus
-- 5 Darkstar

do -- define AWACS Squadrons
    sqdn_960th_AACS = SQUADRON:New("TEMPLATE_ACFT_AWACS_E-3A", 3, "960th AACS")
        :SetGrouping(1) -- 1 in a flight
        :SetParkingIDs({185, 186, 188, 189})
        :SetTakeoffCold()
        :SetCallsign(5, 1) -- Darkstar 1
        :SetTurnoverTime(360)  -- 6 hours
        --:SetAirwing(airwing_552nd_ACW)
        :AddMissionCapability({AUFTRAG.Type.AWACS, AUFTRAG.Type.ALERT5})
    airwing_552nd_ACW:AddSquadron(sqdn_960th_AACS)
    
    sqdn_VAW_121 = SQUADRON:New("TEMPLATE_ACFT_AWACS_E-2D", 3, "VAW-121")
        :SetGrouping(1) -- 1 in a flight
        :SetParkingIDs({85, 86})
        :SetTakeoffCold()
        :SetCallsign(2, 1) -- Magic 1
        :SetTurnoverTime(360)  -- 6 hours
        :SetLivery("VAW-121 1998 600")
        :AddMissionCapability({AUFTRAG.Type.AWACS, AUFTRAG.Type.ALERT5})
        :SetAirwing(airwing_CVW_7)

end


do -- CVW-7 VAW-121
    
    airwing_CVW_7:NewPayload(GROUP:FindByName("TEMPLATE_ACFT_AWACS_E-2D"), -1, {AUFTRAG.Type.AWACS}, 100)
    airwing_CVW_7:AddSquadron(sqdn_VAW_121)
    airwing_CVW_7:AddMission(AUFTRAG:NewALERT5(AUFTRAG.Type.AWACS):SetRequiredAssets(1,1))
end

local orbit_list = {
    AWACS_NE = AUFTRAG_awacs_NE,
    AWACS_SE = AUFTRAG_awacs_SE,
    AWACS_SW  = AUFTRAG_awacs_SW
}

-- Launch Customized AWACS Mission
function launch_AWACS(AUFTRAG_awacs, AIRWING_awacs)
    --local AUFTRAG_awacs = AUFTRAG_awacs
    --math.randomseed(os.time())
    math.random(); math.random(); math.random() 
    local alt = math.random(220,260) * 100
    AUFTRAG_awacs:SetMissionSpeed(300) -- knots
    AUFTRAG_awacs:SetMissionAltitude(alt)
    --AUFTRAG_awacs:SetAssetsStayAlive(true)
    airwing_AddMission(AIRWING_awacs, AUFTRAG_awacs)

    function AUFTRAG_awacs:OnAfterStarted(From, Event, To)
        local active_ops_groups = self:GetOpsGroups()
        local new_ops_group = active_ops_groups[#active_ops_groups]
        local new_ops_unit = new_ops_group:GetUnit()
        local ops_sqdn = new_ops_group.cohort
        local cohort_name = ops_sqdn:GetName()
        local callsign = new_ops_unit:GetCallsign()
        local callsign_index = new_ops_group.callsign.NumberSquad
        local callsign_grpnum = new_ops_group.callsign.NumberGroup
        BASE:E(cohort_name .. " - " .. callsign_index .. " - " .. callsign_grpnum)

        if (callsign_index == 5) then 
            callsign = "DARKSTAR " .. callsign_index
        elseif (callsign_index == 2) then 
            callsign = "MAGIC " .. callsign_index
        end
        local f10_label = "ON STATION: " .. callsign .. "-" ..  callsign_grpnum .. " - " .. self.radio.Freq
        local msn_coord = self:GetTargetCoordinate():Translate(math.random(UTILS.NMToMeters(3), self.orbitLeg), self.orbitHeading)  --:GetMissionWaypointCoord(self:GetOpsGroups()[1])
        local label_id = msn_coord:TextToAll(
            f10_label, 2, {255/255,255/255,0/255},nil,color_gray,nil,10,true
        )

        -- Send message
        local OPSGROUP_awacs = self:GetOpsGroups()[1]
        local freq = self.radio.Freq
        local callsign = OPSGROUP_awacs:GetCallsignName()
        --local rcvr_plyr_id = UNIT_requester:GetPlayerName()
        local msg_txt = "AWACS deployed. Contact " ..  callsign .. " at " .. freq
        MESSAGE:New(msg_txt,15,"Information"):ToBlue() --Unit(UNIT_requester)

        MSRSQ_BLACKJACK:NewTransmission(msg_txt,nil,MSRS_BLACKJACK,nil,1,nil,text,10)

        function self:OnAfterDone(From, Event, To)
            RemoveMark(label_id)
        end
    end
end

-- Add Group Menus
function addSubMenu_MsnSupport_AWACS(MooseGroup)
    --local menu_Support_161st_ARSacft = MENU_GROUP:New(MooseGroup, "161st Air Refueling Wing",  menus_ClientMsnSupport[MooseGroup:GetID()])
    local UNIT_client = MooseGroup:GetFirstUnitAlive()
    local orbit_list = {
        AWACS_NE = AUFTRAG_awacs_NE,
        AWACS_SE = AUFTRAG_awacs_SE,
        AWACS_SW  = AUFTRAG_awacs_SW
    }

    local menu_Support_awacs = MENU_GROUP:New(MooseGroup, "AWACS",  menus_ClientMsnSupport[MooseGroup:GetID()])
        for key,value in pairs(orbit_list) do
            local menu_Support_awacs_type = MENU_GROUP:New(MooseGroup, key,  menu_Support_awacs)
            MENU_GROUP_COMMAND:New(MooseGroup, "E-2D", menu_Support_awacs_type, launch_AWACS, value, airwing_CVW_7)
            MENU_GROUP_COMMAND:New(MooseGroup, "E-3", menu_Support_awacs_type, launch_AWACS, value, airwing_552nd_ACW)
            end
        end
end