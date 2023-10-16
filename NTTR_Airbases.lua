do -- Setup Creech

    AIRBASE_creech = AIRBASE:FindByName("Creech")
    --AIRBASE_creech:MarkParkingSpots()
    do -- Initialize 423nd Wings operating out of Creech
        AIRWING_432nd_WG = AIRWING:New("Warehouse Creech-1", "432nd Wing")
        AIRWING_432nd_WG:SetSafeParkingOff()
        AIRWING_432nd_WG:Start()
    end
    do --[[ Initialize Squadrons operating out of Creech
        SQDN_11th_AS =  SQUADRON:New("TEMPLATE_ACFT_UAV_MQ9_CAS", 6, "11th AS") -- 11th Attack Squadron
            :SetGrouping(1) -- 1 in a flight
            :SetParkingIDs({30, 31, 44, 45, 50})
            :SetTakeoffCold()
            :SetTurnoverTime(60)  -- 1 hours
            :AddMissionCapability({AUFTRAG.Type.CAS, AUFTRAG.Type.GROUNDATTACK, AUFTRAG.Type.BOMBING, AUFTRAG.Type.ALERT5})
        AIRWING_432nd_WG:AddSquadron(SQDN_11th_AS)
        AIRWING_432nd_WG:NewPayload(GROUP:FindByName("TEMPLATE_ACFT_UAV_MQ9_CAS"), -1, 
                                    {AUFTRAG.Type.CAS, AUFTRAG.Type.GROUNDATTACK, AUFTRAG.Type.BOMBING}, 100)                               
        SQDN_15th_AS =  SQUADRON:New("TEMPLATE_ACFT_UAV_MQ1_CAS", 6, "15th AS") -- 11th Attack Squadron
            :SetGrouping(1) -- 1 in a flight
            :SetParkingIDs({33, 35, 36, 37})
            :SetTakeoffCold()
            :SetTurnoverTime(60)  -- 1 hours
            :AddMissionCapability({AUFTRAG.Type.CAS, AUFTRAG.Type.GROUNDATTACK, AUFTRAG.Type.BOMBING, AUFTRAG.Type.ALERT5})
        AIRWING_432nd_WG:AddSquadron(SQDN_15th_AS)
        AIRWING_432nd_WG:NewPayload(GROUP:FindByName("TEMPLATE_ACFT_UAV_MQ1_CAS"), -1, 
                                    {AUFTRAG.Type.CAS, AUFTRAG.Type.GROUNDATTACK, AUFTRAG.Type.BOMBING}, 100)       
        --]]
    end
    do -- Define Creech/432nd Wing AUFTRAGs
        --[[
        AUFTRAG_432nd_Wing_MQ1_alert = AUFTRAG:NewALERT5(AUFTRAG.Type.GROUNDATTACK)
            :AssignSquadrons({SQDN_15th_AS})
            :SetEPLRS(false)
            :SetRequiredAssets(1,1)
            :SetRepeat(99)
        AIRWING_432nd_WG:AddMission(AUFTRAG_432nd_Wing_MQ1_alert)

        AUFTRAG_432nd_Wing_MQ9_alert = AUFTRAG:NewALERT5(AUFTRAG.Type.GROUNDATTACK)
            :AssignSquadrons({SQDN_11th_AS})
            :SetEPLRS(false)
            :SetRequiredAssets(1,1)
            :SetRepeat(99)
        AIRWING_432nd_WG:AddMission(AUFTRAG_432nd_Wing_MQ9_alert)
        ]]--
    end


end

do -- Setup Groom

    AIRBASE_groom = AIRBASE:FindByName("Groom Lake")
    --AIRBASE_groom:MarkParkingSpots()
    do -- Initialize Skunk Works operating out of Nellis
        AIRWING_53rd_WG = AIRWING:New("Warehouse Groom-1", "53rd Wing")
        AIRWING_53rd_WG:Start()
    end
    
    do -- Initialize Squadrons operating out of Nellis
        SQDN_422nd_TES =  SQUADRON:New("TEMPLATE_ACFT_FTR_F-22A_BVR_1SHIP", 6, "422nd TES")
        :SetGrouping(2) -- 2 in a flight
        :SetParkingIDs({20, 28, 29, 39, 40, 41})
        :SetTakeoffCold()
        :SetTurnoverTime(60)  -- 1 hours
        :AddMissionCapability({AUFTRAG.Type.CAP, AUFTRAG.Type.ALERT5})
        AIRWING_53rd_WG:AddSquadron(SQDN_422nd_TES)
        AIRWING_53rd_WG:NewPayload(GROUP:FindByName("TEMPLATE_ACFT_FTR_F-22A_BVR_1SHIP"), -1, 
                                {AUFTRAG.Type.ALERT5, AUFTRAG.Type.CAP, AUFTRAG.Type.ESCORT,
                                 AUFTRAG.Type.PATROLZONE, AUFTRAG.Type.INTERCEPT}, 100)
        
        SQDN_422nd_TES_GDCA =  SQUADRON:New("TEMPLATE_ACFT_FTR_F-22A_BVR_1SHIP", 8, "422nd TES GDCA")
            :SetGrouping(2) -- 2 in a flight
            :SetTakeoffHot()
            :SetTurnoverTime(60)  -- 1 hours
            :AddMissionCapability({AUFTRAG.Type.CAP, AUFTRAG.Type.ALERT5})
        local active_runway = AIRBASE_groom:GetRunwayIntoWind()
        if string.find(AIRBASE_groom:GetRunwayName(), "32") ~= nil then
            SQDN_422nd_TES_GDCA:SetParkingIDs({33, 34, 45, 46, 47, 48}) -- South runup pad
        else
            SQDN_422nd_TES_GDCA:SetParkingIDs({31, 32, 35, 36, 37, 38}) -- North runup pad
        end
        AIRWING_53rd_WG:AddSquadron(SQDN_422nd_TES_GDCA)
        
        SQDN_1st_RS =  SQUADRON:New("TEMPLATE_ACFT_ISR_U-2", 2, "1st RS")
            :SetGrouping(1) -- 2 in a flight
            :SetParkingIDs({24, 30})
            :SetTakeoffCold()
            :SetTurnoverTime(60 * 3)  -- 3 hours
            :AddMissionCapability({AUFTRAG.Type.RECON, AUFTRAG.Type.ALERT5})
        AIRWING_53rd_WG:AddSquadron(SQDN_1st_RS)
        AIRWING_53rd_WG:NewPayload(GROUP:FindByName("TEMPLATE_ACFT_ISR_U-2"), -1, 
                                {AUFTRAG.Type.ALERT5, AUFTRAG.Type.RECON}, 100)

        SQDN_Skunk_Works =  SQUADRON:New("TEMPLATE_ACFT_ISR_SR-71", 2, "Skunk Works")
            :SetGrouping(1) -- # in a flight
            :SetParkingIDs({22})
            :SetTakeoffCold()
            :SetTurnoverTime(60 * 3)  -- 3 hours
            :AddMissionCapability({AUFTRAG.Type.RECON, AUFTRAG.Type.ALERT5})
        AIRWING_53rd_WG:AddSquadron(SQDN_Skunk_Works)
        AIRWING_53rd_WG:NewPayload(GROUP:FindByName("TEMPLATE_ACFT_ISR_SR-71"), -1, {AUFTRAG.Type.ALERT5, AUFTRAG.Type.RECON}, 100)
                                        

    end
    do -- Define 53rd Wing AUFTRAGs
        AUFTRAG_Groom_Alert_F22 = AUFTRAG:NewALERT5(AUFTRAG.Type.ESCORT):SetRequiredAssets(1,3):AssignSquadrons({SQDN_422nd_TES_GDCA})
        AUFTRAG_Groom_Alert_F22:SetRepeat(99)
        AUFTRAG_Groom_Alert_F22:SetEPLRS(false)
        AIRWING_53rd_WG:AddMission(AUFTRAG_Groom_Alert_F22)
        --AUFTRAG_Groom_Alert_F22:OnEventMissionStart(
        --    SCHEDULER_zone_4808a_check:New(nil)
        --)
        AUFTRAG_Groom_Ramp_F22 = AUFTRAG:NewALERT5(AUFTRAG.Type.ESCORT):SetRequiredAssets(1,2):AssignSquadrons({SQDN_422nd_TES})
        AUFTRAG_Groom_Ramp_F22:SetRepeat(99)
        AUFTRAG_Groom_Ramp_F22:SetEPLRS(false)
        AIRWING_53rd_WG:AddMission(AUFTRAG_Groom_Ramp_F22)
        
        AUFTRAG_Groom_Ramp_U2 = AUFTRAG:NewALERT5(AUFTRAG.Type.RECON):SetRequiredAssets(1,1):AssignSquadrons({SQDN_1st_RS})
        AUFTRAG_Groom_Ramp_U2:SetRepeat(99)
        AUFTRAG_Groom_Ramp_U2:SetEPLRS(false)
        --AIRWING_53rd_WG:AddMission(AUFTRAG_Groom_Ramp_U2)

        AUFTRAG_Groom_Ramp_SR71 = AUFTRAG:NewALERT5(AUFTRAG.Type.RECON):SetRequiredAssets(1,1):AssignSquadrons({SQDN_Skunk_Works})
        AUFTRAG_Groom_Ramp_SR71:SetRepeat(99)
        AUFTRAG_Groom_Ramp_SR71:SetEPLRS(false)
        --AIRWING_53rd_WG:AddMission(AUFTRAG_Groom_Ramp_SR71)
    end
    do -- Define Groom Lake Airspace Defense

        --OPERATION_Groom_Defense = OPERATION:New("Groom Lake Defense")
        --OPERATION_Groom_Defense:AddPhase("Active Defense")
   
        --function OPERATION_Groom_Defense:OnAfterPhaseChange(From, Event, To, Phase)
    
            --local current_phase = op_RED_FLAG_ISL_Aairbase_NellisSSLT:GetPhaseActive()
    
            --if string.find(OPERATION_Groom_Defense:GetPhaseName(current_phase), "Active") ~= nil then

        --end
    
    end --

end

do -- Setup Nellis
    -- @field Nevada, fixing the field names since MOOSE is wrong as of 12/29/2021
    AIRBASE.Nevada = {
        ["Nellis_AFB"] = "Nellis",
    }
    AIRBASE_Nellis = AIRBASE:FindByName("Nellis")
    --AIRBASE_Nellis:MarkParkingSpots()
    AIRBASE_Nellis:SetActiveRunwayLanding("21", nil)
    AIRBASE_Nellis:SetActiveRunwayTakeoff("03", nil)

    do -- Parking Ramp Areas
        local colors_gray = {192/255,192/255,192/255}
        local colors_vf11 = {255/255,0/255,0/255}
        local colors_vfa115 = {255/255,225/255,0/255}
        local colors_vfa147 = {255/255,160/255,0/255}
        local colors_vfa146 = {0/255,128/255,255/255}
        local colors_vfa86 = {255/255,90/255,0/255}
        local colors_vfa103 = {0/255,0/255,0/255}
        local colors_vf84 = {255/255,255/255,0/255}
        local colors_vf211 = {0/255,0/255,128/255}
        --ZONE:FindByName("VF-11"  ):DrawZone(2, colors_vf11, 1, {0,0,1}, 1, 1, true)
        ZONE:FindByName("VF-11"  ):GetCoordinate():TextToAll("VF-11", 2, colors_vf11,1,{0,0,1},0, 12,true)
        --ZONE:FindByName("VFA-115"):DrawZone(2, colors_vfa115, 1, colors_vfa115, 1, 1, true)
        ZONE:FindByName("VFA-115"):GetCoordinate():TextToAll("VFA-115", 2, colors_vfa115,nil,colors_gray,0, 12,true)
        --ZONE:FindByName("VFA-147"):DrawZone(2, colors_vfa147, 1, {0,0,0}, .66, 1, true)
        ZONE:FindByName("VFA-147"):GetCoordinate():TextToAll("VFA-147", 2, colors_vfa147,nil,{0,0,0}, 1, 12,true)
        --ZONE:FindByName("VFA-146"):DrawZone(2, colors_vfa146, 1, {51/255, 153/255, 1}, .66, 1, true)
        ZONE:FindByName("VFA-146"):GetCoordinate():TextToAll("VFA-146", 2, colors_vfa146,nil,{51/255, 153/255, 1}, .66, 12,true)
        --ZONE:FindByName("VFA-86" ):DrawZone(2, colors_vfa86 , 1, colors_vfa86 , .66, 1, true)
        ZONE:FindByName("VFA-86" ):GetCoordinate():TextToAll("VFA-86", 2, colors_vfa86,nil,colors_gray,0, 12,true)
        --ZONE:FindByName("VFA-103"):DrawZone(2, colors_vfa103, 1, {1,1,1}, 1, 1, true)
        ZONE:FindByName("VFA-103"):GetCoordinate():TextToAll("VFA-103", 2, colors_vfa103,nil,colors_gray,0, 12,true)
        --ZONE:FindByName("VF-84"  ):DrawZone(2, colors_vf84, 1, colors_vf84, .66, 1, true)
        ZONE:FindByName("VF-84"  ):GetCoordinate():TextToAll("VF-84", 2, colors_vf84,nil,colors_gray,0, 12,true)
        --ZONE:FindByName("VF-211" ):DrawZone(2, colors_vf211, 1, colors_vf211, .66, 1, true)
        ZONE:FindByName("VF-211" ):GetCoordinate():TextToAll("VF-211", 2, colors_vf211,nil,colors_gray,0, 12,true)

    end

    do -- Static T-45 Lineup
        static_t45 = SPAWNSTATIC:NewFromType("T-45")
        init_spot = COORDINATE:New(-00397123, 0, -00017156)
        --[[for i=0,5 do
            local dist = UTILS.FeetToMeters(80) * i + .01
            BASE:E("distance " .. dist)
            local spawn_spot = init_spot:Translate(dist, 271)
            static_t45:InitCoordinate(spawn_spot)
            static_t45:Spawn()
        end--]]
    end

    do -- Static Thunderbirds Lineup
        static_f16 = SPAWNSTATIC:NewFromType("F-16C_50")
        static_f16:InitHeading(220)
        init_spot = COORDINATE:New(-00397549, 0, -00017508)
        --[[for i=0,5 do
            local dist = UTILS.FeetToMeters(80) * i + .01
            BASE:E("distance " .. dist)
            local spawn_spot = init_spot:Translate(dist, 131)
            static_f16:InitCoordinate(spawn_spot)
            static_f16:Spawn()
        end--]]
    end
    do -- Initialize 57th Wing operating our of Nellis
        airwing_57th_WG = AIRWING:New("Warehouse Nellis-1", "57th Wing")
        airwing_57th_WG:SetSafeParkingOff()
        airwing_57th_WG:Start()
    end
    do -- Define 57th Wing Fighter Squadrons
        sqdn_16th_WPS = SQUADRON:New("TEMPLATE_ACFT_FTR_F-16CM_BVR_1SHIP", 6, "16th WPS")
        sqdn_16th_WPS:SetGrouping(2) -- 2 in a flight
          :SetParkingIDs({105, 106, 107, 108, 109, 110})
          :SetTakeoffCold()
          :SetCallsign(1, 1) -- Magic 1
          :SetTurnoverTime(60)  -- 1 hours
          :AddMissionCapability({AUFTRAG.Type.CAP, AUFTRAG.Type.ESCORT, AUFTRAG.Type.ALERT5})
        airwing_57th_WG:NewPayload(GROUP:FindByName("TEMPLATE_ACFT_FTR_F-16CM_BVR_1SHIP"), -1, {AUFTRAG.Type.ALERT5, AUFTRAG.Type.CAP, AUFTRAG.Type.ESCORT, AUFTRAG.Type.INTERCEPT}, 100)
        airwing_57th_WG:AddSquadron(sqdn_16th_WPS)
      
        sqdn_17th_WPS = SQUADRON:New("TEMPLATE_ACFT_FTR_F-15E_CAS_1SHIP", 6, "17th WPS")
        sqdn_17th_WPS:SetGrouping(2) -- 2 in a flight
          :SetParkingIDs({99, 100, 101, 102, 103, 104})
          :SetTakeoffCold()
          :SetCallsign(1, 1) -- Magic 1
          :SetTurnoverTime(60)  -- 1 hours
          :AddMissionCapability({AUFTRAG.Type.CAP, AUFTRAG.Type.ESCORT, AUFTRAG.Type.ALERT5})
          :SetLivery("usaf 414th cts (wa) nellis afb")
          airwing_57th_WG:NewPayload(GROUP:FindByName("TEMPLATE_ACFT_FTR_F-15E_CAS_1SHIP"), -1,
           {AUFTRAG.Type.ALERT5, AUFTRAG.Type.GROUNDATTACK, AUFTRAG.Type.BOMBING, AUFTRAG.Type.CAS}, 100)
          airwing_57th_WG:AddSquadron(sqdn_17th_WPS)
      
          
        sqdn_433th_WPS =  SQUADRON:New("TEMPLATE_ACFT_FTR_F-22A_BVR_1SHIP", 6, "433th WPS")
        sqdn_433th_WPS:SetGrouping(2) -- 2 in a flight
          :SetParkingIDs({93, 94, 95, 96, 97, 98})
          :SetTakeoffCold()
          :SetCallsign(1, 1) -- Magic 1
          :SetTurnoverTime(60)  -- 1 hours
          :AddMissionCapability({AUFTRAG.Type.ALERT5, AUFTRAG.Type.CAP, AUFTRAG.Type.ESCORT, AUFTRAG.Type.INTERCEPT})
          airwing_57th_WG:NewPayload(GROUP:FindByName("TEMPLATE_ACFT_FTR_F-22A_BVR_1SHIP"), -1, {AUFTRAG.Type.ALERT5, AUFTRAG.Type.CAP, AUFTRAG.Type.ESCORT, AUFTRAG.Type.INTERCEPT}, 100)
          airwing_57th_WG:AddSquadron(sqdn_433th_WPS)
      
          -- A-10 callsigns (A-10A, A-10C, A-10CII)
          -- 9  Hawg
          -- 10 Boar
          -- 11 Pig
          -- 12 Tusk
          sqdn_66th_WPS =  SQUADRON:New("TEMPLATE_ACFT_ATK_A-10C_CAS", 4, "66th WPS")
          sqdn_66th_WPS:SetGrouping(1) -- 2 in a flight
          :SetParkingIDs({194, 195, 196, 197, 198, 199, 200, 201, 202, 203, 204, 205})
          :SetTakeoffCold()
          :SetCallsign(1, 1) -- Hawg 1
          :SetLivery("66th WS Nellis AFB, Nevada (WA)")
          :SetTurnoverTime(30)  -- .5 hours
          :AddMissionCapability({AUFTRAG.Type.CAS, AUFTRAG.Type.BOMBING, AUFTRAG.Type.GROUNDATTACK, AUFTRAG.Type.ALERT5})
          airwing_57th_WG:NewPayload(GROUP:FindByName("TEMPLATE_ACFT_ATK_A-10C_CAS"), -1, {AUFTRAG.Type.CAS, AUFTRAG.Type.BOMBING, AUFTRAG.Type.GROUNDATTACK, AUFTRAG.Type.ALERT5}, 100)
          airwing_57th_WG:AddSquadron(sqdn_66th_WPS)
      
    end
    do -- Define 57th Wing Fighter Missions
        auftrag_57th_Wing_A10_alert = AUFTRAG:NewALERT5(AUFTRAG.Type.GROUNDATTACK)
          :AssignSquadrons({sqdn_66th_WPS})
          :SetEPLRS(false)
          :SetRequiredAssets(1,4)
          :SetRepeat(99)
        airwing_57th_WG:AddMission(auftrag_57th_Wing_A10_alert)
    
        auftrag_57th_Wing_F15E_alert = AUFTRAG:NewALERT5(AUFTRAG.Type.GROUNDATTACK)
          :AssignSquadrons({sqdn_17th_WPS})
          :SetEPLRS(false)
          :SetRequiredAssets(1,2)
          :SetRepeat(99)
        --airwing_57th_WG:AddMission(auftrag_57th_Wing_F15E_alert)
    
        auftrag_57th_Wing_F16_alert = AUFTRAG:NewALERT5(AUFTRAG.Type.ESCORT)
          :AssignSquadrons({sqdn_16th_WPS})
          :SetEPLRS(false)
          :SetRequiredAssets(1,2)
          :SetRepeat(99)
        --airwing_57th_WG:AddMission(auftrag_57th_Wing_F16_alert)
    
        auftrag_57th_Wing_F22_alert = AUFTRAG:NewALERT5(AUFTRAG.Type.ESCORT)
          :AssignSquadrons({sqdn_433th_WPS})
          :SetEPLRS(false)
          :SetRequiredAssets(1,2)
          :SetRepeat(99)
        --airwing_57th_WG:AddMission(auftrag_57th_Wing_F22_alert)
    
    end
    do -- Define 57th Wing Helo Squadrons
        sqdn_66th_RQS = SQUADRON:New("TEMPLATE_HELO_UH-60", 6, "66th RQS")
          :SetGrouping(1) -- 1 in a flight
          :SetParkingIDs({156, 157, 158, 159, 160})
          :SetTakeoffCold()
          :SetTurnoverTime(15) 
          :AddMissionCapability({AUFTRAG.Type.TROOPTRANSPORT, AUFTRAG.Type.ALERT5})
          :SetLivery("US Army MEDEVAC")
          airwing_57th_WG:AddSquadron(sqdn_66th_RQS)
          airwing_57th_WG:NewPayload(GROUP:FindByName("TEMPLATE_HELO_UH-60"), -1, {AUFTRAG.Type.TROOPTRANSPORT, AUFTRAG.Type.ALERT5}, 100)


    end
    do -- Define 57th Wing Helo Missions
        auftrag_57th_Wing_H60_alert = AUFTRAG:NewALERT5(AUFTRAG.Type.TROOPTRANSPORT)
            :AssignSquadrons({sqdn_66th_RQS})
            :SetEPLRS(false)
            :SetRequiredAssets(1,2)
            :SetRepeat(99)
        airwing_57th_WG:AddMission(auftrag_57th_Wing_H60_alert)
    end
    do -- Define Nellis Deployed HVA Wings
        airwing_55th_RW = AIRWING:New("Warehouse Nellis-1", "55th Recon Wing")
        airwing_55th_RW:Start()
        airwing_55th_RW:NewPayload(GROUP:FindByName("TEMPLATE_ACFT_ISR_RC-135"), -1, {AUFTRAG.Type.BAI}, 100)

        sqdn_82nd_RECON_SQDN = SQUADRON:New("TEMPLATE_ACFT_ISR_RC-135", 2, "82nd RECON SQDN")
        :SetGrouping(1) -- 1 in a flight
        :SetParkingIDs({187, 188, 189, 190, 192})
        :SetTakeoffCold()
        --:SetCallsign(1, 1) -- Magic 1
        :SetTurnoverTime(360)  -- 6 hours
        :AddMissionCapability(
            {AUFTRAG.Type.ORBIT, AUFTRAG.Type.ALERT5}
        )
        airwing_55th_RW:AddSquadron(sqdn_82nd_RECON_SQDN)


    end
    do -- Define Nellis Deployed Bomber Wings
        do -- 7th Bomber Wing (B-1)
            sqdn_9th_BOMB_SQDN = SQUADRON:New("TEMPLATE_ACFT_BMBR_B1", 2, "9th BOMB SQDN")
                :SetGrouping(1) -- 1 in a flight
                :SetParkingIDs({187, 188, 189, 190, 192})
                :SetTakeoffCold()
                --:SetCallsign(1, 1) -- Magic 1
                :SetTurnoverTime(360)  -- 6 hours
                :AddMissionCapability(
                    {AUFTRAG.Type.BAI, AUFTRAG.Type.BOMBING, AUFTRAG.Type.BOMBRUNWAY, 
                    AUFTRAG.Type.STRIKE, AUFTRAG.Type.ALERT5}
                )
            airwing_7th_BW = AIRWING:New("Warehouse Nellis-1", "7th Bomber Wing")
            airwing_7th_BW:Start()
            airwing_7th_BW:NewPayload(GROUP:FindByName("TEMPLATE_ACFT_BMBR_B1"), -1, {AUFTRAG.Type.BAI}, 100)
            airwing_7th_BW:AddSquadron(sqdn_9th_BOMB_SQDN)
            --airwing_7th_BW:AddMission(auftrag_bmbr_alert)
        end
        do -- define 509th Bomber Wing (B-22)
            sqdn_13th_BOMB_SQDN = SQUADRON:New("TEMPLATE_ACFT_BMBR_B2_16xAGM-154C", 4, "13th BOMB SQDN")
                :SetGrouping(1) -- 1 in a flight
                :SetParkingIDs({187, 188, 189, 190, 192})
                :SetTakeoffCold()
                --:SetCallsign(1, 1) -- Magic 1
                :SetTurnoverTime(360)  -- 6 hours
                :AddMissionCapability(
                    {AUFTRAG.Type.BAI, AUFTRAG.Type.BOMBING, AUFTRAG.Type.BOMBRUNWAY, 
                    AUFTRAG.Type.STRIKE, AUFTRAG.Type.ALERT5, AUFTRAG.Type.ORBIT})
        
            airwing_509th_BW = AIRWING:New("Warehouse Nellis-1", "509th Bomber Wing")
            airwing_509th_BW:Start()
            airwing_509th_BW:NewPayload(GROUP:FindByName("TEMPLATE_ACFT_BMBR_B2_16xAGM"), -1, {AUFTRAG.Type.BAI, AUFTRAG.Type.STRIKE, AUFTRAG.Type.ALERT5, AUFTRAG.Type.ORBIT}, 100)
            airwing_509th_BW:AddSquadron(sqdn_13th_BOMB_SQDN)
            --airwing_2nd_BW:AddMission(auftrag_bmbr_alert)
        end
        do -- define 2nd Bomber Wing (B-52)
            sqdn_96th_BOMB_SQDN = SQUADRON:New("TEMPLATE_ACFT_BMBR_B52_STRIKE", 4, "96th BOMB SQDN")
                :SetGrouping(1) -- 1 in a flight
                :SetParkingIDs({187, 188, 189, 190, 192})
                :SetTakeoffCold()
                --:SetCallsign(1, 1) -- Magic 1
                :SetTurnoverTime(360)  -- 6 hours
                :AddMissionCapability(
                    {AUFTRAG.Type.BAI, AUFTRAG.Type.BOMBING, AUFTRAG.Type.BOMBRUNWAY, 
                    AUFTRAG.Type.STRIKE, AUFTRAG.Type.ALERT5, AUFTRAG.Type.ORBIT})
        
            airwing_2nd_BW = AIRWING:New("Warehouse Nellis-1", "2nd Bomber Wing")
            airwing_2nd_BW:Start()
            airwing_2nd_BW:NewPayload(GROUP:FindByName("TEMPLATE_ACFT_BMBR_B52_STRIKE"), -1, {AUFTRAG.Type.BAI, AUFTRAG.Type.ALERT5, AUFTRAG.Type.ORBIT}, 100)
            airwing_2nd_BW:AddSquadron(sqdn_96th_BOMB_SQDN)
            --airwing_2nd_BW:AddMission(auftrag_bmbr_alert)
        end
    end
    do -- Define Bomber AUFTRAGs
        auftrag_bmbr_alert = AUFTRAG:NewALERT5(AUFTRAG.Type.BAI)
            :SetRequiredAssets(1,1)
    end

    do -- Define CVW-7 Support Squadrons
        SQDN_VAQ_141 = SQUADRON:New("TEMPLATE_ACFT_EW_EA-18G", 6, "VAQ-141")
            :SetGrouping(1) -- 1 in a flight
            :SetParkingIDs({24, 25, 26})
            :SetTakeoffCold()
            :SetCallsign(1, 1) -- Magic 1
            :SetModex(501)
            :SetTurnoverTime(60)  -- 1 hours
            :AddMissionCapability({AUFTRAG.Type.CAP, AUFTRAG.Type.ESCORT, AUFTRAG.Type.SEAD, AUFTRAG.Type.ORBIT, AUFTRAG.Type.ALERT5})
        airwing_CVW_7:NewPayload(GROUP:FindByName("TEMPLATE_ACFT_EW_EA-18G"), -1, {AUFTRAG.Type.CAP, AUFTRAG.Type.ESCORT, AUFTRAG.Type.SEAD, AUFTRAG.Type.ORBIT, AUFTRAG.Type.ALERT5}, 100)
        airwing_CVW_7:AddSquadron(SQDN_VAQ_141)
          --:SetLivery("usaf 414th cts (wa) nellis afb")      
    end
    do -- Define CVW-7 Support Missions
        AUFTRAG_CVW_EA18G_alert = AUFTRAG:NewALERT5(AUFTRAG.Type.CAP)
            :AssignSquadrons({SQDN_VAQ_141})
            :SetEPLRS(false)
            :SetRequiredAssets(1,2)
            :SetRepeat(99)
        airwing_CVW_7:AddMission(AUFTRAG_CVW_EA18G_alert)

    end
end

do -- Setup Tononopah Test
    AIRBASE_Tonopah_Test = AIRBASE:FindByName("Tonopah Test Range")
    --AIRBASE_Tonopah_Test:MarkParkingSpots()
end

do -- Setup Lincoln County
    AIRBASE_Lincoln = AIRBASE:FindByName("Lincoln County")
end

do -- Setup McCarran Intl
    AIRBASE_McCarran = AIRBASE:FindByName("McCarran International")
    AIRBASE_McCarran:SetActiveRunwayLanding("1", true)
    AIRBASE_McCarran:SetActiveRunwayTakeoff("1", false)
end