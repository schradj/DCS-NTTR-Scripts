do -- Define RAT Entry/Exit Zones
    ZONE_RAT_EntryExit_DEN =  ZONE_RADIUS:New("RAT_ENTRY_EXIT_DEN", COORDINATE:New(-00231695, 00224218), UTILS.NMToMeters(10))
    ZONE_RAT_EntryExit_LAX =  ZONE_RADIUS:New("RAT_ENTRY_EXIT_LAX", COORDINATE:New(-00595619, -00446416), UTILS.NMToMeters(10))
    ZONE_RAT_EntryExit_PHX =  ZONE_RADIUS:New("RAT_ENTRY_EXIT_PHX", COORDINATE:New(-00597759, 00222324), UTILS.NMToMeters(10))
    ZONE_RAT_EntryExit_RNO =  ZONE_RADIUS:New("RAT_ENTRY_EXIT_RNO", COORDINATE:New(-00002588, -00448009), UTILS.NMToMeters(10))
    ZONE_RAT_EntryExit_SFO =  ZONE_RADIUS:New("RAT_ENTRY_EXIT_SFO", COORDINATE:New(-00262445, -00447674), UTILS.NMToMeters(10))
    ZONE_RAT_EntryExit_SLC =  ZONE_RADIUS:New("RAT_ENTRY_EXIT_SLC", COORDINATE:New(-00002494, 00223237), UTILS.NMToMeters(10))


end


do -- Crossing Traffic
    RATMAN_xst = RATMANAGER:New(12)
    --RATMAN_xst:SetTspawn(60 * 20)
    function configure_XST_RAT_Settings(rat_object, spawn_num) -- configure random transiting traffic
        rat_object:SetDeparture({
            "RAT_ENTRY_EXIT_DEN",   -- Denver
            "RAT_ENTRY_EXIT_LAX",   -- Los Angeles
            "RAT_ENTRY_EXIT_PHX",   -- Pheonix
            "RAT_ENTRY_EXIT_RNO",   -- Reno
            "RAT_ENTRY_EXIT_SFO",   -- San Francisco
            "RAT_ENTRY_EXIT_SLC"    -- Salt Lake City
        })
        rat_object:SetDestination({
            "RAT_ENTRY_EXIT_DEN",   -- Denver
            "RAT_ENTRY_EXIT_LAX",   -- Los Angeles
            "RAT_ENTRY_EXIT_PHX",   -- Pheonix
            "RAT_ENTRY_EXIT_RNO",   -- Reno
            "RAT_ENTRY_EXIT_SFO",   -- San Francisco
            "RAT_ENTRY_EXIT_SLC"    -- Salt Lake City
        })
        rat_object:SetTakeoffAir()
        rat_object:SetCoalitionAircraft("neutral")
        rat_object:SetMaxCruiseAltitude(UTILS.FeetToMeters(35000))
        rat_object:SetFLcruise(300)
        rat_object:SetMinCruiseAltitude(UTILS.FeetToMeters(20000))
        --rat_object:SetSpawnInterval(60 * math.random(30,90)) -- 30 minutes
        --rat_object:SetSpawnDelay(60 * 60 * (7/spawn_num))
        --rat_object:ContinueJourney()
        --rat_object:SetRespawnDelay(60 * math.random(10, 30))
        rat_object:StatusReports(false)
        rat_object:ATC_Messages(false)
        rat_object:Invisible(true)
        --rat_object:Spawn(spawn_num)
        --rat_object:EnableATC(false)
        RATMAN_xst:Add(rat_object, spawn_num)
    end
    
    
    local rat_xst_a320=RAT:New("TEMPLATE_ACFT_COMM_A-320", "RAT_XST_A320")
    rat_xst_a320:Livery({"US Airways", "United", "Virgin", "Delta Airlines", "American Airlines"})
    configure_XST_RAT_Settings(rat_xst_a320, 4)

    local rat_xst_a330=RAT:New("TEMPLATE_ACFT_COMM_A-330", "RAT_XST_A330")
    rat_xst_a330:Livery({"Air Canada", "US Airways", "DELTA", "Virgin Atlantic", "Swiss", "GulfAir"})
    configure_XST_RAT_Settings(rat_xst_a330, 2)

    local rat_xst_a380=RAT:New("TEMPLATE_ACFT_COMM_A-380", "RAT_XST_A380")
    rat_xst_a380:Livery({"Air France", "BA", "Quantas Airways", "Emirates"})
    configure_XST_RAT_Settings(rat_xst_a380, 1)

    local rat_xst_b727=RAT:New("TEMPLATE_ACFT_COMM_B-727", "RAT_XST_B727")
    rat_xst_b727:Livery({"FedEx", "Delta Airlines"})
    configure_XST_RAT_Settings(rat_xst_b727, 1)

    local rat_xst_b737=RAT:New("TEMPLATE_ACFT_COMM_B-737", "RAT_XST_B737")
    rat_xst_b737:Livery({"AM", "Delta Modern", "Southwest Modern", "UPS", "United Modern"})
    configure_XST_RAT_Settings(rat_xst_b737, 6)

    local rat_xst_b747=RAT:New("TEMPLATE_ACFT_COMM_B-747", "RAT_XST_B747")
    rat_xst_b747:Livery({"KLM - Modern", "Virgin Atlantic Modern", "British Airways - G-CIVT"})
    --configure_XST_RAT_Settings(rat_xst_b747)

    local rat_xst_b757=RAT:New("TEMPLATE_ACFT_COMM_B-757", "RAT_XST_B757")
    rat_xst_b757:Livery({"FedEx", "BA", "DHL", "Delta"})
    configure_XST_RAT_Settings(rat_xst_b757, 1)
    RATMAN_xst:Start()
end 

do -- McCarran Traffic
    ratman_mccarran = RATMANAGER:New(20)
    local RAT_mccarran_janet_shuttle=RAT:New("TEMPLATE_ACFT_COMM_B-737", "RAT_LAS_JANET")
    RAT_mccarran_janet_shuttle:SetDeparture({"McCarran International"})
    RAT_mccarran_janet_shuttle:SetCoalitionAircraft("red")
    RAT_mccarran_janet_shuttle:Livery({"JA"})
    RAT_mccarran_janet_shuttle:SetDestination({"Groom Lake", "Tonopah Test Range"})
    --RAT_mccarran_janet_shuttle:ReturnZone()
    --RAT_mccarran_janet_shuttle:ContinueJourney()
    RAT_mccarran_janet_shuttle:SetSpawnInterval(60 * math.random(20,40)) -- ~20 minutes
    --RAT_mccarran_janet_shuttle:SetSpawnDelay(60 * 10)
    RAT_mccarran_janet_shuttle:SetRespawnDelay(60 * 60 * 6)
    RAT_mccarran_janet_shuttle:StatusReports(false)
    RAT_mccarran_janet_shuttle:ATC_Messages(false)
    --RAT_mccarran_janet_shuttle:EnableATC(false)
    RAT_mccarran_janet_shuttle:Invisible(true)
    RAT_mccarran_janet_shuttle:Spawn(3)
    local mccaran_index = 0
    function configure_McCarran_RAT_Settings(rat_object, spawn_num)
        rat_object:SetDeparture({"McCarran International"})
        rat_object:SetDestination({
        "RAT_ENTRY_EXIT_DEN",   -- Denver
        "RAT_ENTRY_EXIT_LAX",   -- Los Angeles
        "RAT_ENTRY_EXIT_PHX",   -- Pheonix
        "RAT_ENTRY_EXIT_RNO",   -- Reno
        "RAT_ENTRY_EXIT_SFO",   -- San Francisco
        "RAT_ENTRY_EXIT_SLC"    -- Salt Lake City
        })
        rat_object:ReturnZone()
        rat_object:SetTakeoff("hot")
        rat_object:SetCoalitionAircraft("blue")
        rat_object:SetMaxCruiseAltitude(UTILS.FeetToMeters(35000))
        rat_object:SetFLcruise(300)
        rat_object:SetMinCruiseAltitude(UTILS.FeetToMeters(20000))
        rat_object:SetSpawnInterval(60 * math.random(30,90)) -- 30 minutes
        rat_object:SetSpawnDelay(60 * 60 * (7/spawn_num))
        rat_object:ContinueJourney()
        --rat_object:SetRespawnDelay(60 * math.random(10, 30))
        rat_object:StatusReports(false)
        rat_object:ATC_Messages(false)
        rat_object:Invisible(true)
        rat_object:Spawn(spawn_num)
        mccaran_index = mccaran_index + 1
        --rat_object:EnableATC(false)
        --ratman_mccarran:Add(rat_object, 1)
    end
    
    
    local rat_mccarran_a320=RAT:New("TEMPLATE_ACFT_COMM_A-320", "RAT_LAS_A320")
    rat_mccarran_a320:Livery({"US Airways", "United", "Virgin", "Delta Airlines", "American Airlines"})
    configure_McCarran_RAT_Settings(rat_mccarran_a320, 8)

    local rat_mccarran_a330=RAT:New("TEMPLATE_ACFT_COMM_A-330", "RAT_LAS_A330")
    rat_mccarran_a330:Livery({"Air Canada", "US Airways", "DELTA", "Virgin Atlantic", "Swiss", "GulfAir"})
    configure_McCarran_RAT_Settings(rat_mccarran_a330, 4)

    local rat_mccarran_a380=RAT:New("TEMPLATE_ACFT_COMM_A-380", "RAT_LAS_A380")
    rat_mccarran_a380:Livery({"Air France", "BA", "Quantas Airways", "Emirates"})
    configure_McCarran_RAT_Settings(rat_mccarran_a380, 2)

    local rat_mccarran_b727=RAT:New("TEMPLATE_ACFT_COMM_B-727", "RAT_LAS_B727")
    rat_mccarran_b727:Livery({"FedEx", "Delta Airlines"})
    configure_McCarran_RAT_Settings(rat_mccarran_b727, 2)

    local rat_mccarran_b737=RAT:New("TEMPLATE_ACFT_COMM_B-737", "RAT_LAS_B737")
    rat_mccarran_b737:Livery({"AM", "Delta Modern", "Southwest Modern", "UPS", "United Modern"})
    configure_McCarran_RAT_Settings(rat_mccarran_b737, 8)

    local rat_mccarran_b747=RAT:New("TEMPLATE_ACFT_COMM_B-747", "RAT_LAS_B747")
    rat_mccarran_b747:Livery({"KLM - Modern", "Virgin Atlantic Modern", "British Airways - G-CIVT"})
    --configure_McCarran_RAT_Settings(rat_mccarran_b747)

    local rat_mccarran_b757=RAT:New("TEMPLATE_ACFT_COMM_B-757", "RAT_LAS_B757")
    rat_mccarran_b757:Livery({"FedEx", "BA", "DHL", "Delta"})
    configure_McCarran_RAT_Settings(rat_mccarran_b757, 2)

    --ratman_mccarran:SetTspawn(60 * 20)
    --ratman_mccarran:Start(25)
end 

do -- Nellis Traffic


end 
do -- Groom Lake Traffic
    local RAT_groom_nellis_shuttle=RAT:New("TEMPLATE_ACFT_COMM_B-737", "RAT_XTA_JANET")
    RAT_groom_nellis_shuttle:SetDeparture({"Groom Lake", "Tonopah Test Range"})
    RAT_groom_nellis_shuttle:SetCoalitionAircraft("blue")
    RAT_groom_nellis_shuttle:Livery({"JA"})
    RAT_groom_nellis_shuttle:SetDestination({"McCarran International"})
    --RAT_groom_nellis_shuttle:ReturnZone()
    --RAT_groom_nellis_shuttle:ContinueJourney()
    --RAT_groom_nellis_shuttle:SetSpawnDelay(60 * math.random(1,15))
    RAT_groom_nellis_shuttle:SetSpawnInterval(60 * math.random(20,40)) -- ~20 minutes
    RAT_groom_nellis_shuttle:SetRespawnDelay(60 * 60 * 6)
    RAT_groom_nellis_shuttle:StatusReports(false)
    RAT_groom_nellis_shuttle:ATC_Messages(false)
    --RAT_groom_nellis_shuttle:EnableATC(false)

    RAT_groom_nellis_shuttle:Invisible(true)
    RAT_groom_nellis_shuttle:Spawn(3)
end

