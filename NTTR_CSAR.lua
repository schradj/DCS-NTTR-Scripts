   -- Instantiate and start a CSAR for the blue side, with template "Downed Pilot" and alias "Luftrettung"
   local CSAR_nttr_blue = CSAR:New(coalition.side.BLUE,"Downed Pilot","MEDEVAC")
   -- options
   CSAR_nttr_blue.immortalcrew = true -- downed pilot spawn is immortal
   CSAR_nttr_blue.invisiblecrew = false -- downed pilot spawn is visible
   -- start the FSM
   CSAR_nttr_blue:__Start(5)

   -- CSAR Options ------ Commented out if default
   CSAR_nttr_blue.allowDownedPilotCAcontrol = true -- Set to false if you don\'t want to allow control by Combined Arms.
   --CSAR_nttr_blue.allowFARPRescue = true -- allows pilots to be rescued by landing at a FARP or Airbase. Else MASH only!
   --CSAR_nttr_blue.FARPRescueDistance = 1000 -- you need to be this close to a FARP or Airport for the pilot to be rescued.
   CSAR_nttr_blue.autosmoke = true -- automatically smoke a downed pilot\'s location when a heli is near.
   --CSAR_nttr_blue.autosmokedistance = 1000 -- distance for autosmoke
   CSAR_nttr_blue.coordtype = 2 -- Use Lat/Long DDM (0), Lat/Long DMS (1), MGRS (2), Bullseye imperial (3) or Bullseye metric (4) for coordinates.
   CSAR_nttr_blue.csarOncrash = true -- (WIP) If set to true, will generate a downed pilot when a plane crashes as well.
   CSAR_nttr_blue.enableForAI = true -- set to false to disable AI pilots from being rescued.
   --CSAR_nttr_blue.pilotRuntoExtractPoint = true -- Downed pilot will run to the rescue helicopter up to CSAR_nttr_blue.extractDistance in meters. 
   --CSAR_nttr_blue.extractDistance = 500 -- Distance the downed pilot will start to run to the rescue helicopter.
   --CSAR_nttr_blue.immortalcrew = true -- Set to true to make wounded crew immortal.
   --CSAR_nttr_blue.invisiblecrew = false -- Set to true to make wounded crew insvisible.
   --CSAR_nttr_blue.loadDistance = 75 -- configure distance for pilots to get into helicopter in meters.
   --CSAR_nttr_blue.mashprefix = {"MASH"} -- prefixes of #GROUP objects used as MASHes.
   --CSAR_nttr_blue.max_units = 6 -- max number of pilots that can be carried if #CSAR.AircraftType is undefined.
   --CSAR_nttr_blue.messageTime = 15 -- Time to show messages for in seconds. Doubled for long messages.
   CSAR_nttr_blue.radioSound = load_script_dir .. "Saved Games/DCS.openbeta/Missions/My_Sounds/beacon.ogg" -- the name of the sound file to use for the pilots\' radio beacons. 
   --CSAR_nttr_blue.smokecolor = 4 -- Color of smokemarker, 0 is green, 1 is red, 2 is white, 3 is orange and 4 is blue.
   CSAR_nttr_blue.useprefix = false  -- Requires CSAR helicopter #GROUP names to have the prefix(es) defined below.
   ---CSAR_nttr_blue.csarPrefix = { "helicargo", "MEDEVAC"} -- #GROUP name prefixes used for useprefix=true - DO NOT use # in helicopter names in the Mission Editor! 
   --CSAR_nttr_blue.verbose = 0 -- set to > 1 for stats output for debugging.
   -- limit amount of downed pilots spawned by **ejection** events
   --CSAR_nttr_blue.limitmaxdownedpilots = true
   --CSAR_nttr_blue.maxdownedpilots = 10 
   -- allow to set far/near distance for approach and optionally pilot must open doors
   --CSAR_nttr_blue.approachdist_far = 5000 -- switch do 10 sec interval approach mode, meters
   --CSAR_nttr_blue.approachdist_near = 3000 -- switch to 5 sec interval approach mode, meters
   CSAR_nttr_blue.pilotmustopendoors = true -- switch to true to enable check of open doors
   --CSAR_nttr_blue.suppressmessages = false -- switch off all messaging if you want to do your own
   --CSAR_nttr_blue.rescuehoverheight = 20 -- max height for a hovering rescue in meters
   --CSAR_nttr_blue.rescuehoverdistance = 10 -- max distance for a hovering rescue in meters
   -- Country codes for spawned pilots
   --CSAR_nttr_blue.countryblue= country.id.USA
   --CSAR_nttr_blue.countryred = country.id.RUSSIA
   --CSAR_nttr_blue.countryneutral = country.id.UN_PEACEKEEPERS
   --CSAR_nttr_blue.topmenuname = "CSAR" -- set the menu entry name
   --CSAR_nttr_blue.ADFRadioPwr = 1000 -- ADF Beacons sending with 1KW as default

    -- CSAR Experimental Features - WARNING - Here\'ll be dragons!
    --DANGER - For this to work you need to de-sanitize your mission environment (all three entries) in <DCS root>\Scripts\MissionScripting.lua
    --Needs SRS => 1.9.6 to work (works on the **server** side of SRS)
    CSAR_nttr_blue.useSRS = true -- Set true to use FF\'s SRS integration
    CSAR_nttr_blue.SRSPath = srs_path -- adjust your own path in your SRS installation -- server(!)
    CSAR_nttr_blue.SRSchannel = 243.000 -- radio channel
    --CSAR_nttr_blue.SRSModulation = radio.modulation.AM -- modulation
    --CSAR_nttr_blue.SRSport = 5002  -- and SRS Server port
    --CSAR_nttr_blue.SRSCulture = "en-GB" -- SRS voice culture
    --CSAR_nttr_blue.SRSVoice = nil -- SRS voice, relevant for Google TTS
    --CSAR_nttr_blue.SRSGPathToCredentials = nil -- Path to your Google credentials json file, set this if you want to use Google TTS
    --CSAR_nttr_blue.SRSVolume = 1 -- Volume, between 0 and 1
    --CSAR_nttr_blue.SRSGender = "male" -- male or female voice
    
    --CSAR_nttr_blue.csarUsePara = false -- If set to true, will use the LandingAfterEjection Event instead of Ejection. Requires CSAR_nttr_blue.enableForAI to be set to true. --shagrat
    --CSAR_nttr_blue.wetfeettemplate = "man in floating thingy" -- if you use a mod to have a pilot in a rescue float, put the template name in here for wet feet spawns. Note: in conjunction with csarUsePara this might create dual ejected pilots in edge cases.
    --CSAR_nttr_blue.allowbronco = false  -- set to true to use the Bronco mod as a CSAR plane