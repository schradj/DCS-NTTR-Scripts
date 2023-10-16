
do -- Define Tanker Anchor Points
    COORD_tnkr_anchor_AR_230V = COORDINATE:New(-00357480, UTILS.FeetToMeters(18000), 00020272)  
end

function launch_Growler(coord, hdng, alt, GROUP_requester)
    alt = alt or 25000
    AUFTRAG_growler = AUFTRAG:NewORBIT_RACETRACK(
        coord,
        alt,
        hdng,
        20
    )

    AUFTRAG_growler:SetDuration(45*60):AssignSquadrons({SQDN_VAQ_141}):SetEPLRS(true):SetRadio(276.000)
    AUFTRAG_growler:SetMissionSpeed(350)
    airwing_CVW_7:AddMission(AUFTRAG_growler)
    function AUFTRAG_growler:onafterStarted(From, Event, To)
        local OPSGROUP_grwlr = self:GetOpsGroups()[1]
        local freq = self.radio.Freq
        local callsign = OPSGROUP_grwlr:GetCallsignName()
        local msg_txt = "Growler deployed. Contact " ..  callsign .. " at " .. freq
        if (GROUP_requester ~= nil) then
            local UNIT_requester = GROUP_requester:GetFirstUnitAlive()
            local rcvr_plyr_id = UNIT_requester:GetPlayerName()
            msg_txt = rcvr_plyr_id .. ", " .. msg_txt
            MESSAGE:New(msg_txt,15,"Information"):ToUnit(UNIT_requester)
        end
        MSRSQ_BLACKJACK:NewTransmission(msg_txt,nil,MSRS_BLACKJACK,nil,1,nil,nil,nil)
        local jammerSource = OPSGROUP_grwlr:GetDCSUnit(1)
        jammer = SkynetIADSJammer:create(jammerSource, IADS_SEAD_Range)
        function self:onafterExecuting(From, Event, To)
            local OPSGROUP_grwlr = self:GetOpsGroups()[1]
            jammer:MasterArmOn()
        end
        function self:onafterDone(From, Event, To)
            jammer:MasterArmSafe()
        end
    end
end

-- Add Group Menus
function addSubMenu_MsnSupport_Jammers(MooseGroup)
    local UNIT_client = MooseGroup:GetFirstUnitAlive()
    local orbit_list = {
        SEAD_Range = COORDINATE:New(-00460621,0,-00256450),
        Tonopah_Test = AIRBASE_Tonopah_Test:GetCoordinate()
    }
    local menu_Support_jammers = MENU_GROUP:New(MooseGroup, "Jammers",  menus_ClientMsnSupport[MooseGroup:GetID()])
    for key,coord in pairs(orbit_list) do
        local ranges = {10, 20, 30, 40, 50, 60, 70, 80}
        MENU_jammer_tgt = MENU_GROUP:New(MooseGroup, key, menu_Support_jammers)
        for i,range in pairs(ranges) do
            coord_orbit = coord:Translate(UTILS.NMToMeters(range), 90)
            MENU_GROUP_COMMAND:New(MooseGroup, range .. " NM", MENU_jammer_tgt, launch_Growler, coord_orbit, 270, 25000, MooseGroup)
        end
    end
end