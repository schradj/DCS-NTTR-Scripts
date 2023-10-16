

do -- Build NAWDC Aggressor Wing @ Tonopah Test

  tbl_NAWDC_Sqdns = {}
  airwing_NAWDC=AIRWING:New("Warehouse Tonopah Test Range", "Naval Aviation Warfighting Development Center")
  do -- Build NAWDC AWACS Squadrons
    do -- Build KJ-2000 Squadron
      tbl_NAWDC_Sqdns.KJ2000 = SQUADRON:New("TEMPLATE_ACFT_AWACS_KJ-2000", 4, "NAWDC MAINRING")
      tbl_NAWDC_Sqdns.KJ2000:AddMissionCapability({AUFTRAG.Type.AWACS, AUFTRAG.Type.ALERT5})
      airwing_NAWDC:AddSquadron(tbl_NAWDC_Sqdns.KJ2000)
      airwing_NAWDC:NewPayload(GROUP:FindByName("TEMPLATE_ACFT_AWACS_KJ-2000"), -1, {AUFTRAG.Type.AWACS}, 100)
    end
  end -- NAWDC Attack/Light Bomber Squadrons
  do -- Build NAWDC Attack/Light Bomber Squadrons
    do -- Build Su-25T Squadron
      tbl_NAWDC_Sqdns.Su25T=SQUADRON:New("TEMPLATE_ACFT_ATK_Su-25T_A2G_1SHIP", 32, "NAWDC FROGFOOT")
      tbl_NAWDC_Sqdns.Su25T:AddMissionCapability({AUFTRAG.Type.CAS, AUFTRAG.Type.STRIKE, AUFTRAG.Type.BAI, AUFTRAG.Type.BOMBING, AUFTRAG.Type.ALERT5})
      airwing_NAWDC:AddSquadron(tbl_NAWDC_Sqdns.Su25T)
      airwing_NAWDC:NewPayload(GROUP:FindByName("TEMPLATE_ACFT_ATK_Su-25T_A2G_1SHIP"), -1, {AUFTRAG.Type.CAS, AUFTRAG.Type.STRIKE, AUFTRAG.Type.BAI, AUFTRAG.Type.BOMBING}, 80)
    end
  end -- NAWDC Attack/Light Bomber Squadrons
  do -- Build NAWDC Bomber Squadrons
    do -- Build H-6 Squadron
      tbl_NAWDC_Sqdns.H6=SQUADRON:New("TEMPLATE_ACFT_BMBR_H-6_CLEAN_1SHIP", 32, "NAWDC BADGER")
      tbl_NAWDC_Sqdns.H6:AddMissionCapability({AUFTRAG.Type.STRIKE, AUFTRAG.Type.BAI, AUFTRAG.Type.BOMBING, AUFTRAG.Type.ALERT5})
      airwing_NAWDC:AddSquadron(tbl_NAWDC_Sqdns.H6)
      airwing_NAWDC:NewPayload(GROUP:FindByName("TEMPLATE_ACFT_BMBR_H-6_ASUW_YJ-83K"), -1, {AUFTRAG.Type.STRIKE, AUFTRAG.Type.BAI, AUFTRAG.Type.BOMBING}, 100)
      airwing_NAWDC:NewPayload(GROUP:FindByName("TEMPLATE_ACFT_BMBR_H-6_ASUW_YJ-12"), -1, {AUFTRAG.Type.STRIKE, AUFTRAG.Type.BAI, AUFTRAG.Type.BOMBING}, 100)
      airwing_NAWDC:NewPayload(GROUP:FindByName("TEMPLATE_ACFT_BMBR_H-6_A2G_KD-63"), -1, {AUFTRAG.Type.STRIKE, AUFTRAG.Type.BAI, AUFTRAG.Type.BOMBING}, 100)
      airwing_NAWDC:NewPayload(GROUP:FindByName("TEMPLATE_ACFT_BMBR_H-6_A2G_KD-20"), -1, {AUFTRAG.Type.STRIKE, AUFTRAG.Type.BAI, AUFTRAG.Type.BOMBING}, 100)

    end
  end -- NAWDC Bomber Squadrons
  do -- Build NAWDC Fighter/Multi-Role Squadrons
    do -- Build J-10 Squadron
      tbl_NAWDC_Sqdns.J10A=SQUADRON:New("TEMPLATE_ACFT_FTR_J-10A_BVR_1SHIP", 32, "NAWDC FIREBIRD")
      tbl_NAWDC_Sqdns.J10A:AddMissionCapability({AUFTRAG.Type.GCICAP, AUFTRAG.Type.INTERCEPT, AUFTRAG.Type.CAP, AUFTRAG.Type.ALERT5})
      tbl_NAWDC_Sqdns.J10A:SetGrouping(2) -- 2 in a flight

      airwing_NAWDC:AddSquadron(tbl_NAWDC_Sqdns.J10A)
      airwing_NAWDC:NewPayload(GROUP:FindByName("TEMPLATE_ACFT_FTR_J-10A_WVR_1SHIP"), -1, {AUFTRAG.Type.GCICAP, AUFTRAG.Type.INTERCEPT, AUFTRAG.Type.CAP}, 80)
      airwing_NAWDC:NewPayload(GROUP:FindByName("TEMPLATE_ACFT_FTR_J-10A_BVR_1SHIP"), -1, {AUFTRAG.Type.GCICAP, AUFTRAG.Type.INTERCEPT, AUFTRAG.Type.CAP}, 80)
      airwing_NAWDC:NewPayload(GROUP:FindByName("TEMPLATE_ACFT_FTR_J-10A_BVR_1SHIP"), -1, {AUFTRAG.Type.GCICAP, AUFTRAG.Type.INTERCEPT, AUFTRAG.Type.CAP}, 80)
    end
    do -- Build J-11 Squadron
      tbl_NAWDC_Sqdns.J11A=SQUADRON:New("TEMPLATE_ACFT_FTR_J-11A_BVR_1SHIP", 32, "NAWDC FLANKER-L")
      --tbl_NAWDC_Sqdns.J11A:SetParkingIDs({16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33})
      tbl_NAWDC_Sqdns.J11A:AddMissionCapability({AUFTRAG.Type.GCICAP, AUFTRAG.Type.INTERCEPT, AUFTRAG.Type.CAP, AUFTRAG.Type.ALERT5})
      tbl_NAWDC_Sqdns.J11A:SetGrouping(2) -- 2 in a flight
      airwing_NAWDC:AddSquadron(tbl_NAWDC_Sqdns.J11A)
      airwing_NAWDC:NewPayload(GROUP:FindByName("TEMPLATE_ACFT_FTR_J-11A_BVR_1SHIP"), -1, {AUFTRAG.Type.GCICAP, AUFTRAG.Type.INTERCEPT, AUFTRAG.Type.CAP}, 80)
    end
    do -- Build JF-17 Squadron
      tbl_NAWDC_Sqdns.JF17=SQUADRON:New("TEMPLATE_ACFT_FTR_JF-17_BVR_1SHIP", 32, "NAWDC THUNDER")
      tbl_NAWDC_Sqdns.JF17:AddMissionCapability({AUFTRAG.Type.GCICAP, AUFTRAG.Type.INTERCEPT, AUFTRAG.Type.CAP, AUFTRAG.Type.ALERT5})
      tbl_NAWDC_Sqdns.JF17:SetGrouping(2) -- 2 in a flight
      airwing_NAWDC:AddSquadron(tbl_NAWDC_Sqdns.JF17)
      airwing_NAWDC:NewPayload(GROUP:FindByName("TEMPLATE_ACFT_FTR_JF-17_BVR_1SHIP"), -1, {AUFTRAG.Type.GCICAP, AUFTRAG.Type.INTERCEPT, AUFTRAG.Type.CAP}, 80)
    end
    do -- Build MiG-21 Squadron
        tbl_NAWDC_Sqdns.MiG21 = SQUADRON:New("TEMPLATE_ACFT_FTR_MiG-21_WVR_1SHIP", 32, "NAWDC FISHBED")
        tbl_NAWDC_Sqdns.MiG21:AddMissionCapability({AUFTRAG.Type.ORBIT, AUFTRAG.Type.GCICAP, AUFTRAG.Type.INTERCEPT, AUFTRAG.Type.CAP, AUFTRAG.Type.ALERT5})
        tbl_NAWDC_Sqdns.MiG21:SetGrouping(1) -- 2 in a flight
        airwing_NAWDC:AddSquadron(tbl_NAWDC_Sqdns.MiG21)
        airwing_NAWDC:NewPayload(GROUP:FindByName("TEMPLATE_ACFT_FTR_MiG-21_WVR_1SHIP"), -1, {AUFTRAG.Type.ORBIT, AUFTRAG.Type.GCICAP, AUFTRAG.Type.INTERCEPT, AUFTRAG.Type.CAP}, 80)
    end
    do -- Build MiG-23 Squadron
      tbl_NAWDC_Sqdns.MiG23=SQUADRON:New("TEMPLATE_ACFT_FTR_MiG-23_BVR_1SHIP", 32, "NAWDC FLOGGER")
      tbl_NAWDC_Sqdns.MiG23:AddMissionCapability({AUFTRAG.Type.GCICAP, AUFTRAG.Type.INTERCEPT, AUFTRAG.Type.CAP, AUFTRAG.Type.ALERT5})
      tbl_NAWDC_Sqdns.MiG23:SetGrouping(2) -- 2 in a flight
      airwing_NAWDC:AddSquadron(tbl_NAWDC_Sqdns.MiG23)
      airwing_NAWDC:NewPayload(GROUP:FindByName("TEMPLATE_ACFT_FTR_MiG-23_BVR_1SHIP"), -1, {AUFTRAG.Type.GCICAP, AUFTRAG.Type.INTERCEPT, AUFTRAG.Type.CAP}, 80)
    end
    do -- Build MiG-25 Squadron
      tbl_NAWDC_Sqdns.MiG25=SQUADRON:New("TEMPLATE_ACFT_FTR_MiG-25PD_BVR_1SHIP", 32, "NAWDC FOXBAT")
      tbl_NAWDC_Sqdns.MiG25:AddMissionCapability({AUFTRAG.Type.GCICAP, AUFTRAG.Type.INTERCEPT, AUFTRAG.Type.CAP, AUFTRAG.Type.ALERT5})
      tbl_NAWDC_Sqdns.MiG25:SetGrouping(2) -- 2 in a flight
      airwing_NAWDC:AddSquadron(tbl_NAWDC_Sqdns.MiG25)
      airwing_NAWDC:NewPayload(GROUP:FindByName("TEMPLATE_ACFT_FTR_MiG-25PD_BVR_1SHIP"), -1, {AUFTRAG.Type.GCICAP, AUFTRAG.Type.INTERCEPT, AUFTRAG.Type.CAP}, 80)
    end
    do -- Build MiG-29A Squadron
      tbl_NAWDC_Sqdns.MiG29A=SQUADRON:New("TEMPLATE_ACFT_FTR_MiG-29A_BVR_1SHIP", 32, "NAWDC FULCRUM-A")
      tbl_NAWDC_Sqdns.MiG29A:AddMissionCapability({AUFTRAG.Type.GCICAP, AUFTRAG.Type.INTERCEPT, AUFTRAG.Type.CAP, AUFTRAG.Type.ALERT5})
      :SetGrouping(2) -- 2 in a flight
      airwing_NAWDC:AddSquadron(tbl_NAWDC_Sqdns.MiG29A)
      airwing_NAWDC:NewPayload(GROUP:FindByName("TEMPLATE_ACFT_FTR_MiG-29A_BVR_1SHIP"), -1, {AUFTRAG.Type.GCICAP, AUFTRAG.Type.INTERCEPT, AUFTRAG.Type.CAP}, 80)
    end
    do -- Build MiG-29S Squadron
      tbl_NAWDC_Sqdns.MiG29S=SQUADRON:New("TEMPLATE_ACFT_FTR_MiG-29S_BVR_1SHIP", 32, "NAWDC FULCRUM-C")
      tbl_NAWDC_Sqdns.MiG29S:AddMissionCapability({AUFTRAG.Type.GCICAP, AUFTRAG.Type.INTERCEPT, AUFTRAG.Type.CAP, AUFTRAG.Type.ALERT5})
      tbl_NAWDC_Sqdns.MiG29S:SetGrouping(2) -- 2 in a flight
      airwing_NAWDC:AddSquadron(tbl_NAWDC_Sqdns.MiG29S)
      airwing_NAWDC:NewPayload(GROUP:FindByName("TEMPLATE_ACFT_FTR_MiG-29S_BVR_1SHIP"), -1, {AUFTRAG.Type.GCICAP, AUFTRAG.Type.INTERCEPT, AUFTRAG.Type.CAP}, 80)
    end
    do -- Build MiG-31 Squadron
      tbl_NAWDC_Sqdns.MiG31=SQUADRON:New("TEMPLATE_ACFT_FTR_MiG-31_BVR_1SHIP", 32, "NAWDC FOXHOUND")
      tbl_NAWDC_Sqdns.MiG31:AddMissionCapability({AUFTRAG.Type.GCICAP, AUFTRAG.Type.INTERCEPT, AUFTRAG.Type.CAP, AUFTRAG.Type.ALERT5})
      tbl_NAWDC_Sqdns.MiG31:SetGrouping(2) -- 2 in a flight
      airwing_NAWDC:AddSquadron(tbl_NAWDC_Sqdns.MiG31)
      airwing_NAWDC:NewPayload(GROUP:FindByName("TEMPLATE_ACFT_FTR_MiG-31_BVR_1SHIP"), -1, {AUFTRAG.Type.GCICAP, AUFTRAG.Type.INTERCEPT, AUFTRAG.Type.CAP}, 80)
    end
    do -- Build Su-27 Squadron
      tbl_NAWDC_Sqdns.Su27=SQUADRON:New("TEMPLATE_ACFT_FTR_Su-27_BVR_1SHIP", 32, "NAWDC FLANKER-A")
      tbl_NAWDC_Sqdns.Su27:AddMissionCapability({AUFTRAG.Type.GCICAP, AUFTRAG.Type.INTERCEPT, AUFTRAG.Type.CAP, AUFTRAG.Type.ALERT5})
      tbl_NAWDC_Sqdns.Su27:SetGrouping(2) -- 2 in a flight
      airwing_NAWDC:AddSquadron(tbl_NAWDC_Sqdns.Su27)
      airwing_NAWDC:NewPayload(GROUP:FindByName("TEMPLATE_ACFT_FTR_Su-27_BVR_1SHIP"), -1, {AUFTRAG.Type.GCICAP, AUFTRAG.Type.INTERCEPT, AUFTRAG.Type.CAP}, 80)
    end
    do -- Build Su-30 Squadron
      tbl_NAWDC_Sqdns.Su30=SQUADRON:New("TEMPLATE_ACFT_FTR_Su-30_BVR_1SHIP", 32, "NAWDC FLANKER-C")
      tbl_NAWDC_Sqdns.Su30:AddMissionCapability({AUFTRAG.Type.GCICAP, AUFTRAG.Type.INTERCEPT, AUFTRAG.Type.CAP, AUFTRAG.Type.ALERT5})
      tbl_NAWDC_Sqdns.Su30:SetGrouping(2) -- 2 in a flight
      airwing_NAWDC:AddSquadron(tbl_NAWDC_Sqdns.Su30)
      airwing_NAWDC:NewPayload(GROUP:FindByName("TEMPLATE_ACFT_FTR_Su-30_BVR_1SHIP"), -1, {AUFTRAG.Type.GCICAP, AUFTRAG.Type.INTERCEPT, AUFTRAG.Type.CAP}, 80)
    end
    do -- Build Su-33 Squadron
      tbl_NAWDC_Sqdns.Su33=SQUADRON:New("TEMPLATE_ACFT_FTR_Su-33_BVR_1SHIP", 32, "NAWDC FLANKER-D")
      tbl_NAWDC_Sqdns.Su33:AddMissionCapability({AUFTRAG.Type.GCICAP, AUFTRAG.Type.INTERCEPT, AUFTRAG.Type.CAP, AUFTRAG.Type.ALERT5})
      tbl_NAWDC_Sqdns.Su33:SetGrouping(2) -- 2 in a flight
      airwing_NAWDC:AddSquadron(tbl_NAWDC_Sqdns.Su33)
      airwing_NAWDC:NewPayload(GROUP:FindByName("TEMPLATE_ACFT_FTR_Su-33_BVR_1SHIP"), -1, {AUFTRAG.Type.GCICAP, AUFTRAG.Type.INTERCEPT, AUFTRAG.Type.CAP}, 80)
    end
    do -- Build Su-35 Squadron
      tbl_NAWDC_Sqdns.Su35=SQUADRON:New("TEMPLATE_ACFT_FTR_Su-35S_BVR_1SHIP", 32, "NAWDC FLANKER-E")
      tbl_NAWDC_Sqdns.Su35:AddMissionCapability({AUFTRAG.Type.GCICAP, AUFTRAG.Type.INTERCEPT, AUFTRAG.Type.CAP, AUFTRAG.Type.ALERT5})
      tbl_NAWDC_Sqdns.Su35:SetGrouping(2) -- 2 in a flight
      airwing_NAWDC:AddSquadron(tbl_NAWDC_Sqdns.Su35)
      airwing_NAWDC:NewPayload(GROUP:FindByName("TEMPLATE_ACFT_FTR_Su-35S_BVR_1SHIP"), -1, {AUFTRAG.Type.GCICAP, AUFTRAG.Type.INTERCEPT, AUFTRAG.Type.CAP}, 80)
    end
    do -- Build Su-57 Squadron
      tbl_NAWDC_Sqdns.Su57=SQUADRON:New("TEMPLATE_ACFT_FTR_Su-57_BVR_1SHIP", 32, "NAWDC FELON")
      tbl_NAWDC_Sqdns.Su57:AddMissionCapability({AUFTRAG.Type.GCICAP, AUFTRAG.Type.INTERCEPT, AUFTRAG.Type.CAP, AUFTRAG.Type.ALERT5})
      tbl_NAWDC_Sqdns.Su57:SetGrouping(2) -- 2 in a flight
      airwing_NAWDC:AddSquadron(tbl_NAWDC_Sqdns.Su57)
      airwing_NAWDC:NewPayload(GROUP:FindByName("TEMPLATE_ACFT_FTR_Su-57_BVR_1SHIP"), -1, {AUFTRAG.Type.GCICAP, AUFTRAG.Type.INTERCEPT, AUFTRAG.Type.CAP}, 80)
    end
  end -- NAWDC Fighter/Multi-Role Squadrons
  do -- Build NAWDC Helo Squadrons
    do -- Build Mi-8 Squadron
      tbl_NAWDC_Sqdns.Mi8=SQUADRON:New("TEMPLATE_HELO_LIFT_Mi-8MTV2_GUNS_1SHIP", 32, "NAWDC HIP")
      tbl_NAWDC_Sqdns.Mi8:SetParkingIDs({66, 67, 68, 69})
      tbl_NAWDC_Sqdns.Mi8:AddMissionCapability({AUFTRAG.Type.TRANSPORT, AUFTRAG.Type.CARGOTRANSPORT, AUFTRAG.Type.HOVER, AUFTRAG.Type.ALERT5})
      airwing_NAWDC:AddSquadron(tbl_NAWDC_Sqdns.Mi8)
      airwing_NAWDC:NewPayload(GROUP:FindByName("TEMPLATE_HELO_LIFT_Mi-8MTV2_GUNS_1SHIP"), -1, {AUFTRAG.Type.TROOPTRANSPORT, AUFTRAG.Type.CARGOTRANSPORT, AUFTRAG.Type.HOVER}, 100)
    end
    do -- Build Mi-8 Squadron
      tbl_NAWDC_Sqdns.Mi24P=SQUADRON:New("TEMPLATE_HELO_ATK_Mi-24P_CAS_1SHIP", 32, "NAWDC HIND-P")
      tbl_NAWDC_Sqdns.Mi24P:SetParkingIDs({66, 67, 68, 69})
      tbl_NAWDC_Sqdns.Mi24P:AddMissionCapability({AUFTRAG.Type.CAS, AUFTRAG.Type.TRANSPORT, AUFTRAG.Type.CARGOTRANSPORT, AUFTRAG.Type.HOVER, AUFTRAG.Type.ALERT5})
      airwing_NAWDC:AddSquadron(tbl_NAWDC_Sqdns.Mi24P)
      airwing_NAWDC:NewPayload(GROUP:FindByName("TEMPLATE_HELO_ATK_Mi-24P_CAS_1SHIP"), -1, {AUFTRAG.Type.CAS, AUFTRAG.Type.HOVER}, 100)
    end
  end -- NAWDC Helo Squadrons
  airwing_NAWDC:SetSafeParkingOff()
  airwing_NAWDC:SetAllowSpawnOnClientParking()
  airwing_NAWDC:Start()

end

do -- Build Red Mission Support Menu
  MENU_MissionSupport_Red = MENU_COALITION:New(coalition.side.RED, "Request Mission Support")
end
do -- Build NAWDC Missions
  AUFTRAG_r_awacs_nawdc = AUFTRAG:NewAWACS(COORDINATE:New(-00209065,0,-00250149), 26000, nil, 50, 30)
  AUFTRAG_r_awacs_nawdc:AssignSquadrons({tbl_NAWDC_Sqdns.KJ2000}):SetDuration(120*60)
  MENU_COALITION_COMMAND:New(coalition.side.RED, "Launch AWACS", MENU_MissionSupport_Red, airwing_AddMission, airwing_NAWDC,  AUFTRAG_r_awacs_nawdc)
end






auftrag_aggrs_alert = AUFTRAG:NewALERT5(AUFTRAG.Type.CAP):SetRequiredAssets(1,4)

do -- define 64th Aggressor Squadron - F-16
  spawn_64th_AGRS_F16 = SPAWN:NewWithAlias( "TEMPLATE_ACFT_FTR_F-16CM_BVR_1SHIP", "64th_AGRS_F16" )
  :InitUnControlled(true)
  :InitAIOff(true)
  :InitCoalition(coalition.side.RED)
  :InitCountry(country.id.AGGRESSORS)
  :InitLivery("USAF 64th Aggressor SQN-Splinter")
  :OnSpawnGroup(function(SpawnGroup)    
    SpawnGroup:SetCommandInvisible(true)
    SpawnGroup:EnableEmission(false)
    end
  )
  spawn_64th_AGRS_F16:SpawnAtParkingSpot(AIRBASE:FindByName("Nellis"), {120, 119}, SPAWN.Takeoff.Cold) 
  spawn_64th_AGRS_F16:SpawnAtParkingSpot(AIRBASE:FindByName("Nellis"), {118, 117}, SPAWN.Takeoff.Cold) 
  spawn_64th_AGRS_F16:SpawnAtParkingSpot(AIRBASE:FindByName("Nellis"), {116, 115}, SPAWN.Takeoff.Cold) 
  
end

function launch_aggressors(spawn_group)

  local grp = spawn_group:GetFirstAliveGroup()

  fltGrp = FLIGHTGROUP:New(grp)
  fltGrp:StartUncontrolled()
  for i=1,#route_XST_NTTR_RED_AIR_CORRIDOR_INGRESS do
    fltGrp:AddWaypoint(route_XST_NTTR_RED_AIR_CORRIDOR_INGRESS[i])
  end
  function fltGrp:onafterPassingFinalWaypoint(From, Event, To)
    local orbit_pt = ZONE:FindByName("A2A_RANGE_BFM_RED"):GetCoordinate(UTILS.FeetToMeters(20000))
    fltGrp:AddMission(AUFTRAG:NewCAP(ZONE:FindByName("A2A_RANGE_BFM_BLUE"), 20000, 350, orbit_pt, 90):SetDuration(30*60))
    fltGrp:SwitchInvisible(false)
    fltGrp:SwitchEmission(true)

  end
end
  

-- Add Group Menus
function addSubMenu_MsnSupport_Aggressors(MooseGroup)
    menu_Support_64th_AGRS_F16 = MENU_GROUP:New(MooseGroup, "64th Aggressors Squadron", menus_ClientMsnSupport[MooseGroup:GetID()])
    MENU_GROUP_COMMAND:New(MooseGroup, "Request 2xF-16", menu_Support_64th_AGRS_F16, launch_aggressors, spawn_64th_AGRS_F16)
end