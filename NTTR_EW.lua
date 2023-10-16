do



do -- Define AWACS Anchor Points
    --coord_awacs_anchor_BLACKJACK = COORDINATE:New(-00303284, UTILS.FeetToMeters(25000), -00019712)  -- N37, 5.00'   W114, 35.75'
end


do -- Define AWACS AUFTRAGs
    --auftrag_awacs_BLACKJACK = AUFTRAG:NewAWACS(
    --    coord_awacs_anchor_BLACKJACK, -- where to orbit
    --    25000, -- orbit altitude in ft
    --    325, -- orbit speed in knots
    --    35, -- heading
    ---    50 -- length in nmi
    -- )
    --:SetRadio(377.8)
    --function auftrag_awacs_BLACKJACK:OnAfterRequested(EventData)
    --    local mooseGrp_awacs = EventData.IniGroup
    --    local auftrag_escortAwacs = AUFTRAG:NewEscort(mooseGrp_awacs)
    --    airwing_57th_WG:AddMission(auftrag_escortAwacs)
    --end    
    

    auftrag_ew_alert = AUFTRAG:NewALERT5(AUFTRAG.Type.SEAD)
    :SetRequiredAssets(1,2)

end


do -- define AWACS Squadrons
    sqdn_VAQ_140 = SQUADRON:New("TEMPLATE_ACFT_EW_EA-6B", 3, "VAQ-140")
        :SetGrouping(1) -- 1 in a flight
        :SetParkingIDs({24, 26}) --, 25})
        :SetTakeoffCold()
        :SetCallsign(1, 1)
        :SetTurnoverTime(360)  -- 6 hours
        :AddMissionCapability({AUFTRAG.Type.SEAD, AUFTRAG.Type.ALERT5})


end

do -- CVW-7 VAQ-140
    
    airwing_CVW_7:NewPayload(GROUP:FindByName("TEMPLATE_ACFT_EW_EA-6B"), -1, {AUFTRAG.Type.SEAD}, 100)
    airwing_CVW_7:AddSquadron(sqdn_VAQ_140)
    --airwing_CVW_7:AddMission(AUFTRAG:NewALERT5(AUFTRAG.Type.SEAD):SetRequiredAssets(1,1))
end

-- Add Group Menus
--function addSubMenu_MsnSupport_AWACS(MooseGroup)
--    MENU_GROUP_COMMAND:New(MooseGroup, "AWACS", menus_ClientMsnSupport[MooseGroup:GetID()], airwing_AddMission, airwing_552nd_ACW, auftrag_awacs_BLACKJACK)
--end


end
