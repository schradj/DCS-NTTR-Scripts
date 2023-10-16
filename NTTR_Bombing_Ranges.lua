-- VNAO MOOSE RANGE Script Edit
--- Save target sheet.
-- @param #RANGE self
-- @param #string _playername Player name.
-- @param #RANGE.StrafeResult result Results table.
function RANGE:_SaveTargetSheet( _playername, result ) -- RangeBoss Specific Function

    --- Function that saves data to file
    local function _savefile( filename, data )
      local f = io.open( filename, "wb" )
      if f then
        f:write( data )
        f:close()
      else
        env.info( "RANGEBOSS EDIT - could not save target sheet to file" )
        -- self:E(self.lid..string.format("ERROR: could not save target sheet to file %s.\nFile may contain invalid characters.", tostring(filename)))
      end
    end
  
    -- Set path or default.
    local path = self.targetpath
    if lfs then
      path = path or lfs.writedir() .. [[Logs\]]
    end
  
    -- Create unused file name.
    local filename = nil
    for i = 1, 9999 do
  
      -- Create file name
      if self.targetprefix then
        filename = string.format( "%s_%s-%04d.csv", self.targetprefix, result.airframe, i )
      else
        local name = UTILS.ReplaceIllegalCharacters( _playername, "_" )
        filename = string.format( "RANGERESULTS-%s_Targetsheet-%s-%04d.csv", self.rangename, name, i )
      end
  
      -- Set path.
      if path ~= nil then
        filename = path .. "\\" .. filename
      end
  
      -- Check if file exists.
      local _exists = UTILS.FileExists( filename )
      if not _exists then
        break
      end
    end
  
    -- Header line
    local data="Name,Target,Distance,Radial,Quality,Rounds Fired,Rounds Hit,Rounds Quality,Attack Heading,Weapon,Airframe,Mission Time,OS Time\n"
  
    local attackHeading = result.heading -- VNAO Edit - Added
    local distance=result.distance
    local weapon=result.weapon
    local target=result.name
    local radial=result.radial
    local quality=result.quality
    local airframe=result.airframe
    local target = result.name
    local airframe = result.airframe
    local roundsFired = result.roundsFired
    local roundsHit = result.roundsHit
    local strafeResult = result.roundsQuality
    -- local time = UTILS.SecondsToClock( result.time ) -- VNAO Edit - Commented out
    local time = result.clock -- VNAO Edit - Added
    local date = "n/a"
  
  
    local tempfile = io.open("d:/targetsheet-"..tostring(timer.getAbsTime())..".lua","w")
    tempfile:write("temp = "..ROLLN.print_table(result))
    tempfile:close()
  
    if os then
      date = os.date()
    end
    data=data..string.format("%s,%s,%.2f,%03d,%s,%03d,%03d,%s,%03d,%s,%s,%s,%s", _playername, target, distance, radial, quality, roundsFired, roundsHit, strafeResult, attackHeading, weapon, airframe, time, date)
  
    -- Save file.
    _savefile( filename, data )
  end

--




sound_file_path = load_script_dir .. "Saved Games/DCS.openbeta/Missions/MOOSE_SOUND-1.0/MOOSE_SOUND-1.0/RANGE/Range Soundfiles/"

BASE:TraceOnOff(true)
BASE:TraceLevel(1)
BASE:TraceClass('BEACON')
--DiscordRangeReporting by Sickdog 

local playerAltForRangeData = 0 --"altitudeNotSet!"
local playerPitchForRangeData = 0 --"pitchNotSet!"
local playerHeadingForRangeData = 0 --"headingNotSet!"
-- local weaponUsedRange_Discord_Script = "weapon name not set!"
GunFireStart = EVENTHANDLER:New():HandleEvent(EVENTS.ShootingStart)
ShootingEvent = EVENTHANDLER:New():HandleEvent(EVENTS.Shot)-- Occurs whenever any unit in a mission fires a weapon. But not any machine gun or autocannon based weapon, those are handled by shooting_start.


function GunFireStart:OnEventShootingStart(EventData)
    if EventData.IniPlayerName ~= nil then -- A player crashed or ejected.
        local PlayerName = EventData.IniPlayerName
            local PlayerUnit = EventData.IniUnit
            playerAltForRangeData = PlayerUnit:GetAltitude()
            playerPitchForRangeData = PlayerUnit:GetPitch()
            playerHeadingForRangeData = PlayerUnit:GetHeading()
            weaponUsedAdamScript = "cannon rounds"
    end
end

function ShootingEvent:OnEventShot(EventData) --Only picking up players that fire weapons I think 3/7/21. 8/13/21: Discovered techinically this is only even from Moose that contains weapon data in the table
    if EventData.IniUnit:GetCoalitionName() == "Blue" then
        if EventData.IniPlayerName ~= nil then 
            local PlayerUnit = EventData.IniUnit
            playerAltForRangeData = PlayerUnit:GetAltitude()
            playerPitchForRangeData = PlayerUnit:GetPitch()
            playerHeadingForRangeData = PlayerUnit:GetHeading()
        end
    end
end

function displayStrafeResult(strafePit)
    -- local name = Straferesult.player
    -- local quality = Straferesult.roundsQuality
       
    if  clientStrafed == true then
        result={}
        result.messageType = 4 
        result.callsign = Straferesult.player
        result.airframe = Straferesult.airframe 
        result.theatre = env.mission.theatre
        result.rangeName = strafePit
        result.missionType = "1"
       --result.mizTime = UTILS.SecondsToClock(timer.getAbsTime())
        result.strafeAccuracy = Straferesult.strafeAccuracy 
        result.midate=UTILS.GetDCSMissionDate()
        result.strafeScore = "notSet"
        result.bombScore = "N/A"
        if invalidStrafe == true then
            result.roundsQuality = "* INVALID - PASSED FOUL LINE *"
            result.strafeScore = "0"
        else
            result.roundsQuality = Straferesult.roundsQuality
            
            if result.roundsQuality == "DEADEYE PASS" then
                result.strafeScore = "5"
                result.roundsQuality = "DEADEYE"
            elseif result.roundsQuality == "EXCELLENT PASS" then
                result.strafeScore = "4"
                result.roundsQuality = "EXCELLENT"
            elseif result.roundsQuality == "GOOD PASS" then
                result.strafeScore = "3"
                result.roundsQuality = "GOOD"
            elseif result.roundsQuality == "INEFFECTIVE PASS" then
                result.strafeScore = "2"
                result.roundsQuality = "INEFFECTIVE"
            elseif result.roundsQuality == "POOR PASS" then
                result.strafeScore = "1"
                result.roundsQuality = "POOR"
            elseif result.roundsQuality == "* INVALID - PASSED FOUL LINE *" then
                result.strafeScore = "0"
            else
                result.strafeScore = "ERROR"
            end
        end

        result.quality = Straferesult.quality
        result.roundsFired = Straferesult.roundsFired
        result.roundsHit = Straferesult.roundsHit

        if result.airframe == "FA-18C_hornet" then
            result.weapon = "M61A1 Vulcan"
        elseif result.airframe == "F-14B" then
            result.weapon = "M61A1 Vulcan"
        elseif result.airframe == "F-14A-135-GR" then
            result.weapon = "M61A1 Vulcan"
        elseif result.airframe == "AV8BNA" then
            result.weapon = "GAU-12 Equalizer"
        elseif result.airframe == "M-2000C" then
            result.weapon = "DEFA 554"
        elseif result.airframe == "F-16C_50" then
            result.weapon = "M61A1 Vulcan"
        elseif result.airframe == "F-15C" then
            result.weapon = "M61A1 Vulcan"
        elseif result.airframe == "F-5E-3" then
            result.weapon = "20 mm M39A2 Revolver cannon"
        elseif result.airframe == "A-10C" then
            result.weapon = "GAU-8/A Avenger"
        elseif result.airframe == "A-10C_2" then
            result.weapon = "GAU-8/A Avenger"
        elseif result.airframe == "UH-1H" then
            result.weapon = "M134 minigun" 
        elseif result.airframe == "P-51D-30-NA" then
            result.weapon = "0.50 caliber AN/M2 Browning machine guns"      
        else
            result.weapon = "(unkown) CANNON"
        end
       
        result.radial = 0
        result.distance = 0
        result.altitude = playerAltForRangeData*3.28084
        result.pitch = playerPitchForRangeData
        result.heading = playerHeadingForRangeData

        env.info('Range_Discord_reporting_script RANGE Script: SENDING: HypeMan.sendBotTable(result)')
        HypeMan.sendBotTable(result)
        env.info('Range_Discord_reporting_script RANGE Script: SENT:  HypeMan.sendBotTable(result)')
        self:_SaveTargetSheet(result.callsign, result)


        -- debug
         HypeMan.sendBotMessage(JSON:encode(result), "Range lua")

        result = nil
    else
        env.info('Range_Discord_reporting_script RANGE Script: STRAFE:   NOT SHOWING RESULTS, A FALSE/UNINTENDED STRAFE RUN ')
        trigger.action.outText('STRAFE:  ABORTED', 5 )

    end
    clientRollingIn = false
    clientStrafed = false
    invalidStrafe = false

end

local SetClient = SET_CLIENT:New():FilterCoalitions("blue"):FilterStart()
function createRollinZone(zone_name, unit_name, width, depth)
    local width = width or 450
    local depth = depth or 2750
    local UNIT_pitUnit = UNIT:FindByName(unit_name)
    local atk_heading = UNIT_pitUnit:GetHeading() 
    local COORD_pit = COORDINATE:NewFromVec3(UNIT_pitUnit:GetPointVec3())
    local COORD_pit_1 = COORD_pit:Translate(width/2, atk_heading - 90)
    local COORD_pit_2 = COORD_pit:Translate(width/2, atk_heading + 90)
    local COORD_pit_3 = COORD_pit_2:Translate(depth, atk_heading - 180)
    local COORD_pit_4 = COORD_pit_1:Translate(depth, atk_heading - 180)
    local ZONE_RollinZone = ZONE_POLYGON:NewFromPointsArray(
        zone_name, { COORD_pit_1:GetVec2(), COORD_pit_2:GetVec2(), COORD_pit_3:GetVec2(), COORD_pit_4:GetVec2() })
    ZONE_RollinZone:DrawZone(2, {192/255,192/255,192/255}, 1, {0,0,1}, 0, 2, true)
    return ZONE_RollinZone
end
local ZONE_63B_EastPitRollin = createRollinZone("R63B East Strafe Pit Roll-In Zone", "R-63B Class A Range Towers-2" ) -- Foul Line Unit
local ZONE_63B_WestPitRollin = createRollinZone("R63B West Strafe Pit Roll-In Zone", "R-63B Class A Range Towers-3" ) -- Foul Line Unit
local ZONE_64C_EastPitRollin = createRollinZone("R64C East Strafe Pit Roll-In Zone", "R-64C Class A Range Towers-2" ) -- Foul Line Unit
local ZONE_64C_WestPitRollin = createRollinZone("R64C West Strafe Pit Roll-In Zone", "R-64C Class A Range Towers-3" ) -- Foul Line Unit
function CLIENT_IN_STRAFE_PIT_ZONE()
    -- Range reporting functions below.
    SetClient:ForEachClient(function(client)
       if (client ~= nil) and (client:IsAlive()) then
            local playerName = client:GetPlayerName()
            if client:IsInZone(ZONE_63B_EastPitRollin) and clientRollingIn == false then
                clientRollingIn = false
                timer.scheduleFunction(displayStrafeResults, "R63B Strafe Lane R", timer.getTime() + 13)
                Straferesult.airframe = client:GetTypeName()
                HypeMan.sendBotMessage("in pit R63B Strafe R")
            elseif client:IsInZone(ZONE_63B_WestPitRollin) and clientRollingIn == false then
                clientRollingIn = false
                timer.scheduleFunction(displayStrafeResults, "R63B Strafe Lane L", timer.getTime() + 13)
                Straferesult.airframe = client:GetTypeName()
                HypeMan.sendBotMessage("in pit R63B Strafe L")
            elseif client:IsInZone(ZONE_64C_EastPitRollin) and clientRollingIn == false then
                clientRollingIn = false
                timer.scheduleFunction(displayStrafeResults, "R64C Strafe Lane R", timer.getTime() + 13)
                Straferesult.airframe = client:GetTypeName()
                HypeMan.sendBotMessage("in pit R64C Strafe R")
            elseif client:IsInZone(ZONE_64C_WestPitRollin) and clientRollingIn == false then
                clientRollingIn = false
                timer.scheduleFunction(displayStrafeResults, "R64C Strafe Lane L", timer.getTime() + 13)
                Straferesult.airframe = client:GetTypeName()
                HypeMan.sendBotMessage("in pit R64C Strafe L")
            end
        end
    end)

    timer.scheduleFunction(CLIENT_IN_STRAFE_PIT_ZONE,nil,timer.getTime() + 3)
end

CLIENT_IN_STRAFE_PIT_ZONE()

do -- Build Range 62A
    range_62 = RANGE:New("62")
    range_62:SetRangeControl(377.800) -- BLACKJACK
    range_62:SetInstructorRadio(234.250)
    range_62:SetSoundfilesPath(sound_file_path)
    range_62:TrackMissilesOFF()
    range_62:SetAutosaveOn()
    range_62:SetRangeZone(ZONE_Range_62)
    range_62:SetFunkManOn()

    -- Range 62A Targets
    range_62:AddBombingTargetGroup(GROUP:FindByName("62-01")) -- FIVE ARMORED VEHICLES
    range_62:AddBombingTargetGroup(GROUP:FindByName("62-02")) -- THREE ECHELONED TANK FORMATIONS
    range_62:AddBombingTargetGroup(GROUP:FindByName("62-04")) -- THREE ECHELONED TANK FORMATIONS

    -- Range 62B Targets
    -- Gotham City Urban Operations Complex (UOC), which comprises target groups 62-10, -20, -30, -40, -50, -60, -70, -80, and -90

    --range_62B:AddBombingTargetGroup(GROUP:FindByName("62-03")) -- INSURGENT VILLAGE
	--range_62B:AddBombingTargetGroup(GROUP:FindByName("62-08")) -- FAST TRACK
	--range_62B:AddBombingTargetGroup(GROUP:FindByName("62-09")) -- LANTIRN VILLAGE
	--range_62B:AddBombingTargetGroup(GROUP:FindByName("62-11")) -- DAMNATION ALLEY
	--range_62B:AddBombingTargetGroup(GROUP:FindByName("62-12")) -- CHEMICAL/BIOLOGICAL MUNITIONS STORAGE BUNKERS
	--range_62B:AddBombingTargetGroup(GROUP:FindByName("62-13")) -- LARGE MILITARY COMPOUND
	--range_62B:AddBombingTargetGroup(GROUP:FindByName("62-14")) -- FRONT GATE SENTRY
	--range_62B:AddBombingTargetGroup(GROUP:FindByName("62-21")) -- NEW JACK CITY
	--range_62B:AddBombingTargetGroup(GROUP:FindByName("62-22")) -- INSURGENT VILLAGE
	--range_62B:AddBombingTargetGroup(GROUP:FindByName("62-31")) -- GLENN Q. MEMORIAL AIRFIELD
	--range_62B:AddBombingTargetGroup(GROUP:FindByName("62-32")) -- GLENN Q. MEMORIAL AIRFIELD
	--range_62B:AddBombingTargetGroup(GROUP:FindByName("62-41")) -- MEDICAL CLINICS
	--range_62B:AddBombingTargetGroup(GROUP:FindByName("62-42")) -- BELTWAY
	--range_62B:AddBombingTargetGroup(GROUP:FindByName("62-43")) -- HVTs EGRESSING THE AIRPORT
	--range_62B:AddBombingTargetGroup(GROUP:FindByName("62-44")) -- SCUD MISSILE CONVOY
	--range_62B:AddBombingTargetGroup(GROUP:FindByName("62-45")) -- COMM BUILDING
	--range_62B:AddBombingTargetGroup(GROUP:FindByName("62-51")) -- BROADWAY
	--range_62B:AddBombingTargetGroup(GROUP:FindByName("62-52")) -- FIRE DEPARTEMENT
	--range_62B:AddBombingTargetGroup(GROUP:FindByName("62-53")) -- APARTMENT ALLEY
	--range_62B:AddBombingTargetGroup(GROUP:FindByName("62-54")) -- MOSQUE
	--range_62B:AddBombingTargetGroup(GROUP:FindByName("62-55")) -- PARLIAMENT
	--range_62B:AddBombingTargetGroup(GROUP:FindByName("62-56")) -- HVT MEETING
	--range_62B:AddBombingTargetGroup(GROUP:FindByName("62-61")) -- SOUK
	--range_62B:AddBombingTargetGroup(GROUP:FindByName("62-62")) -- SECURITY COMPOUND
	--range_62B:AddBombingTargetGroup(GROUP:FindByName("62-63")) -- CLASSROOM NORTH
	--range_62B:AddBombingTargetGroup(GROUP:FindByName("62-71")) -- UNIVERSITY
	--range_62B:AddBombingTargetGroup(GROUP:FindByName("62-72")) -- SHOPPING DISTRICT
	--range_62B:AddBombingTargetGroup(GROUP:FindByName("62-73")) -- GRAND PALACE
	--range_62B:AddBombingTargetGroup(GROUP:FindByName("62-74")) -- HOTEL CALIFORNIA
	--range_62B:AddBombingTargetGroup(GROUP:FindByName("62-75")) -- BUSINESS DISTRICT
	--range_62B:AddBombingTargetGroup(GROUP:FindByName("62-76")) -- RIVERSIDE HOTEL
	--range_62B:AddBombingTargetGroup(GROUP:FindByName("62-77")) -- ENTERTAINMENT DISTRICT
	--range_62B:AddBombingTargetGroup(GROUP:FindByName("62-78")) -- HOSPITAL
	--range_62B:AddBombingTargetGroup(GROUP:FindByName("62-79")) -- EAST BELTWAY
	--range_62B:AddBombingTargetGroup(GROUP:FindByName("62-81")) -- INDUSTRIAL SECTOR
	--range_62B:AddBombingTargetGroup(GROUP:FindByName("62-83")) -- INTERSECTION
	--range_62B:AddBombingTargetGroup(GROUP:FindByName("62-91")) -- SHANTY TOWN
	--range_62B:AddBombingTargetGroup(GROUP:FindByName("62-92")) -- POWER PLANT
	--range_62B:AddBombingTargetGroup(GROUP:FindByName("62-93")) -- VEHICLE LOADING AREA
    MENU_COALITION_COMMAND:New(coalition.side.BLUE, "Activate Range 62", MENU_BLACKJACK_Bomb_Rngs, activateRange, range_62, {"R-62", "62-"})
    --activateRange(range_62, {"R-62", "62-"})

    --[[
    function range_62:OnAfterImpact(From, Event, To, result, player)  
        result.messageType = 4
        result.callsign = player.playername
        result.theatre = env.mission.theatre
        result.rangeName = self.rangename
        result.missionType = "1"
        -- result.mizTime = UTILS.SecondsToClock(timer.getAbsTime())
        result.midate=UTILS.GetDCSMissionDate()
        result.strafeAccuracy = "N/A"
        result.strafeQuality = "N/A"
        result.altitude = playerAltForRangeData*3.28084
        result.pitch = playerPitchForRangeData
        result.heading = playerHeadingForRangeData
        _playername = player.playername
        result.strafeScore = "N/A"
        result.bombScore = "notSet"
    
        if result.quality == "SHACK" then
            result.bombScore = "5"
        elseif result.quality == "EXCELLENT" then
            result.bombScore = "4"
        elseif result.quality == "GOOD" then
            result.bombScore = "3"
        elseif result.quality == "INEFFECTIVE" then
            result.bombScore = "2"
        elseif result.quality == "POOR" then
            result.bombScore = "1"	
        end
    
        env.info('Range_Discord_reporting_script RANGE Script: SENDING HypeMan.sendBotTable(result)')
        HypeMan.sendBotTable(result)
    
        env.info('Range_Discord_reporting_script RANGE Script: Called _SaveTargetSheet')
        self:_SaveTargetSheet(_playername, result)
    end
    ]]--
end

do -- Build Range 63B Conventional Range

    range_63B = RANGE:New("63B")
    range_63B:SetSRS(srs_path)
    range_63B:SetSRSRangeControl(361.600, radio.modulation.AM, nil, nil, nil, "R-63B Class A Range Towers-1") -- Range control reports hit assessments
    range_63B:SetSRSRangeInstructor(377.800, radio.modulation.AM, nil, nil, nil, "R-63B Class A Range Towers-1") -- BLACKJACK, Instructor radio will inform players when they enter or exit the range zone and provide the radio frequency of the range control for hit assessment. 
    --range_63B:SetSoundfilesPath(sound_file_path)
    range_63B:TrackMissilesOFF()
    range_63B:SetBombtrackThreshold(55)
    range_63B:SetAutosaveOn()
    range_63B:SetRangeZone(ZONE:New("63"))
    range_63B:SetFunkManOn()

    range_63B:AddBombingTargets({"R63BEC", "R63BWC"}) -- E and W Target Circles
    range_63B:AddBombingTargetGroup(GROUP:FindByName("63-01")) -- TANK STRAFE TARGET (7 armored vehicles in the 63B dry lake bed)
    range_63B:AddBombingTargetGroup(GROUP:FindByName("63-02")) -- NORTH BOMB CIRCLE/TANK (NUCLEAR)
    range_63B:AddBombingTargetGroup(GROUP:FindByName("63-03")) -- FOUR CONCRETE BUNKERS
    range_63B:AddBombingTargetGroup(GROUP:FindByName("63-05")) -- RESUPPLY CONVOY
    --range_63B:AddBombingTargetGroup({"63-12")) -- SENSOR-FUZED WEAPON (SFW) TARGET
    local heading_63B_Strafe_L2 = UNIT:FindByName("R63B Strafe Lane L2"):GetHeading()
    local heading_63B_Strafe_R2 = UNIT:FindByName("R63B Strafe Lane R2"):GetHeading()
    range_63B:AddStrafePit({"R63B Strafe Lane L1", "R63B Strafe Lane L2", "R63B Strafe Lane L3"},
                            3000, 300, heading_63B_Strafe_L2, true, 20, 610)
    range_63B:AddStrafePit({"R63B Strafe Lane R1", "R63B Strafe Lane R2", "R63B Strafe Lane R3"},
                            3000, 300, heading_63B_Strafe_R2, true, 20, 610)
    --range_63B:AddStrafePitGroup(GROUP:FindByName("63-10")) -- A-10 30MM DU TARGET
    --range_63B:AddStrafePitGroup(GROUP:FindByName("63-15")) -- TANK STRAFE TARGET
    --range_63B:Start()
    activateRange(range_63B, {"R-63", "63-"})
    --MENU_COALITION_COMMAND:New(coalition.side.BLUE, "Activate Range 63B", MENU_BLACKJACK_Bomb_Rngs, activateRange, range_63B, {"R-63", "63-"})
    --[[
    function range_63B:OnAfterImpact(From, Event, To, result, player)  
        result.messageType = 4
        result.callsign = player.playername
        result.theatre = env.mission.theatre
        result.rangeName = self.rangename
        result.missionType = "1"
        -- result.mizTime = UTILS.SecondsToClock(timer.getAbsTime())
        result.midate=UTILS.GetDCSMissionDate()
        result.strafeAccuracy = "N/A"
        result.strafeQuality = "N/A"
        result.altitude = playerAltForRangeData*3.28084
        result.pitch = playerPitchForRangeData
        result.heading = playerHeadingForRangeData
        _playername = player.playername
        result.strafeScore = "N/A"
        result.bombScore = "notSet"
    
        if result.quality == "SHACK" then
            result.bombScore = "5"
        elseif result.quality == "EXCELLENT" then
            result.bombScore = "4"
        elseif result.quality == "GOOD" then
            result.bombScore = "3"
        elseif result.quality == "INEFFECTIVE" then
            result.bombScore = "2"
        elseif result.quality == "POOR" then
            result.bombScore = "1"	
        end
    
        env.info('Range_Discord_reporting_script RANGE Script: SENDING HypeMan.sendBotTable(result)')
        HypeMan.sendBotTable(result)
    
        env.info('Range_Discord_reporting_script RANGE Script: Called _SaveTargetSheet')
        self:_SaveTargetSheet(_playername, result)
    end
    ]]--
end

do -- Build Range 64

    range_64 = RANGE:New("64")
    range_64:SetSRS(srs_path)
    range_64:SetSRSRangeControl(288.800, radio.modulation.AM, nil, nil, nil, "R-64C Class A Range Towers-1") -- Range control reports hit assessments
    range_64:SetSRSRangeInstructor(377.800, radio.modulation.AM, nil, nil, nil, "R-64C Class A Range Towers-1") -- BLACKJACK, Instructor radio will inform players when they enter or exit the range zone and provide the radio frequency of the range control for hit assessment. 
    --range_64:SetSoundfilesPath(sound_file_path)
    range_64:TrackMissilesOFF()
    range_64:SetBombtrackThreshold(55)
    range_64:SetAutosaveOn()
    range_64:SetRangeZone(ZONE_Range_64) --ZONE:New("64"))
    range_64:SetFunkManOn()

    -- Range 64A Targets
    range_64:AddBombingTargetGroup(GROUP:FindByName("64-10"))--, nil) -- TANK PLATOON
    range_64:AddBombingTargetGroup(GROUP:FindByName("64-11"))--, nil) -- ARMORED VEHICLES
    range_64:AddBombingTargetGroup(GROUP:FindByName("64-12")) -- JDAM GRID (WIP)

    -- Range 64B Targets
    range_64:AddBombingTargetGroup(GROUP:FindByName("64-13")) -- CHEMICAL WEAPONS STORAGE FACILITY
    range_64:AddBombingTargetGroup(GROUP:FindByName("64-14")) -- CONVOY
    range_64:AddBombingTargetGroup(GROUP:FindByName("64-15")) -- ARMORED VEHICLES
    range_64:AddBombingTargetGroup(GROUP:FindByName("64-17")) -- ARTILLERY BATTERY
    range_64:AddBombingTargetGroup(GROUP:FindByName("64-19")) -- ARMORED VEHICLES

    -- Range 64C Targets
    range_64:AddBombingTargets({"R64CEC", "R64CWC"}) -- E and W Target Circles
    local heading_64C_Strafe_L2 = UNIT:FindByName("R64C Strafe Lane L2"):GetHeading()
    local heading_64C_Strafe_R2 = UNIT:FindByName("R64C Strafe Lane R2"):GetHeading()
    range_64:AddStrafePit({"R64C Strafe Lane L1", "R64C Strafe Lane L2", "R64C Strafe Lane L3"}, 3000, 300, heading_64C_Strafe_L2, true, 20, 610)
    range_64:AddStrafePit({"R64C Strafe Lane R1", "R64C Strafe Lane R2", "R64C Strafe Lane R3"}, 3000, 300, heading_64C_Strafe_R2, true, 20, 610)
    range_64:AddBombingTargetGroup(GROUP:FindByName("64-05")) -- FUEL TANKER
    range_64:AddBombingTargetGroup(GROUP:FindByName("64-08")) -- MILITARY VEHICLES
    --range_64C:AddBombingTargetGroup({"64-09"}) -- 4 SHIPPING CONTAINERS -- Jettison Only

    --MENU_COALITION_COMMAND:New(coalition.side.BLUE, "Activate Range 64", MENU_BLACKJACK_Bomb_Rngs, activateRange, range_64, {"R-64", "64-"})
    activateRange(range_64, {"R-64", "64-"})
    --[[
    function range_64:OnAfterImpact(From, Event, To, result, player)  
        result.messageType = 4
        result.callsign = player.playername
        result.theatre = env.mission.theatre
        result.rangeName = self.rangename
        result.missionType = "1"
        -- result.mizTime = UTILS.SecondsToClock(timer.getAbsTime())
        result.midate=UTILS.GetDCSMissionDate()
        result.strafeAccuracy = "N/A"
        result.strafeQuality = "N/A"
        result.altitude = playerAltForRangeData*3.28084
        result.pitch = playerPitchForRangeData
        result.heading = playerHeadingForRangeData
        _playername = player.playername
        result.strafeScore = "N/A"
        result.bombScore = "notSet"
    
        if result.quality == "SHACK" then
            result.bombScore = "5"
        elseif result.quality == "EXCELLENT" then
            result.bombScore = "4"
        elseif result.quality == "GOOD" then
            result.bombScore = "3"
        elseif result.quality == "INEFFECTIVE" then
            result.bombScore = "2"
        elseif result.quality == "POOR" then
            result.bombScore = "1"	
        end
    
        env.info('Range_Discord_reporting_script RANGE Script: SENDING HypeMan.sendBotTable(result)')
        HypeMan.sendBotTable(result)
    
        env.info('Range_Discord_reporting_script RANGE Script: Called _SaveTargetSheet')
        self:_SaveTargetSheet(_playername, result)
    end
    ]]--
end

do -- Build Range 65
    --range_65C = RANGE:New("65C")
    --range_65C:SetRangeControl(377.800) -- BLACKJACK
    --range_65C:SetInstructorRadio(225.450)
    --range_65C:SetSoundfilesPath(sound_file_path)
    --range_65C:TrackMissilesOFF()
    --range_65C:SetAutosaveOn()

    --range_65C:Start()
end

do -- Build Range 71N Conventional Range

    range_71N = RANGE:New("71N")
    range_71N:SetSRS(srs_path)
    range_71N:SetSRSRangeControl(335.450, radio.modulation.AM, nil, nil, nil, "R-71N Class A Range Towers-1") -- Range control reports hit assessments
    range_71N:SetSRSRangeInstructor(377.800, radio.modulation.AM, nil, nil, nil, "R-71N Class A Range Towers-1") -- BLACKJACK, Instructor radio will inform players when they enter or exit the range zone and provide the radio frequency of the range control for hit assessment. 
    --range_71N:SetSoundfilesPath(sound_file_path)
    range_71N:TrackMissilesOFF()
    range_71N:SetBombtrackThreshold(55)
    range_71N:SetAutosaveOn()
    range_71N:SetRangeZone(ZONE:New("71N"))
    range_71N:SetFunkManOn()

    range_71N:AddBombingTargets({"R71NEC", "R71NWC"}) -- E and W Target Circles
    --range_71N:AddBombingTargetGroup(GROUP:FindByName("63-01")) -- TANK STRAFE TARGET (7 armored vehicles in the 63B dry lake bed)
    --range_71N:AddBombingTargetGroup(GROUP:FindByName("63-02")) -- NORTH BOMB CIRCLE/TANK (NUCLEAR)
    --range_71N:AddBombingTargetGroup(GROUP:FindByName("63-03")) -- FOUR CONCRETE BUNKERS
    --range_71N:AddBombingTargetGroup(GROUP:FindByName("63-05")) -- RESUPPLY CONVOY
    --range_71N:AddBombingTargetGroup({"63-12")) -- SENSOR-FUZED WEAPON (SFW) TARGET
    local heading_71N_Strafe_L2 = UNIT:FindByName("R71N Strafe Lane L2"):GetHeading()
    local heading_71N_Strafe_R2 = UNIT:FindByName("R71N Strafe Lane R2"):GetHeading()
    range_71N:AddStrafePit({"R71N Strafe Lane L1", "R71N Strafe Lane L2", "R71N Strafe Lane L3"},
                            3000, 300, heading_71N_Strafe_L2, true, 20, 610)
    range_71N:AddStrafePit({"R71N Strafe Lane R1", "R71N Strafe Lane R2", "R71N Strafe Lane R3"},
                            3000, 300, heading_71N_Strafe_R2, true, 20, 610)
    --range_71N:AddStrafePitGroup(GROUP:FindByName("63-10")) -- A-10 30MM DU TARGET
    --range_71N:AddStrafePitGroup(GROUP:FindByName("63-15")) -- TANK STRAFE TARGET
    --range_71N:Start()
    activateRange(range_71N, {"R-71N", "71-"})
    --MENU_COALITION_COMMAND:New(coalition.side.BLUE, "Activate Range 63B", MENU_BLACKJACK_Bomb_Rngs, activateRange, range_63B, {"R-63", "63-"})
    --[[
    function range_63B:OnAfterImpact(From, Event, To, result, player)  
        result.messageType = 4
        result.callsign = player.playername
        result.theatre = env.mission.theatre
        result.rangeName = self.rangename
        result.missionType = "1"
        -- result.mizTime = UTILS.SecondsToClock(timer.getAbsTime())
        result.midate=UTILS.GetDCSMissionDate()
        result.strafeAccuracy = "N/A"
        result.strafeQuality = "N/A"
        result.altitude = playerAltForRangeData*3.28084
        result.pitch = playerPitchForRangeData
        result.heading = playerHeadingForRangeData
        _playername = player.playername
        result.strafeScore = "N/A"
        result.bombScore = "notSet"
    
        if result.quality == "SHACK" then
            result.bombScore = "5"
        elseif result.quality == "EXCELLENT" then
            result.bombScore = "4"
        elseif result.quality == "GOOD" then
            result.bombScore = "3"
        elseif result.quality == "INEFFECTIVE" then
            result.bombScore = "2"
        elseif result.quality == "POOR" then
            result.bombScore = "1"	
        end
    
        env.info('Range_Discord_reporting_script RANGE Script: SENDING HypeMan.sendBotTable(result)')
        HypeMan.sendBotTable(result)
    
        env.info('Range_Discord_reporting_script RANGE Script: Called _SaveTargetSheet')
        self:_SaveTargetSheet(_playername, result)
    end
    ]]--
end