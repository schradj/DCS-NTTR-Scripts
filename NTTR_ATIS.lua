-- @field Nevada, fixing the field names since MOOSE is wrong as of 12/29/2021
AIRBASE.Nevada = {
    ["Creech_AFB"] = "Creech",
    ["Groom_Lake_AFB"] = "Groom Lake",
    ["McCarran_International_Airport"] = "McCarran International",
    ["Nellis_AFB"] = "Nellis",
    ["Beatty_Airport"] = "Beatty",
    ["Boulder_City_Airport"] = "Boulder City",
    ["Echo_Bay"] = "Echo Bay",
    ["Henderson_Executive_Airport"] = "Henderson Executive",
    ["Jean_Airport"] = "Jean",
    ["Laughlin_Airport"] = "Laughlin",
    ["Lincoln_County"] = "Lincoln County",
    ["Mesquite"] = "Mesquite",
    ["Mina_Airport_3Q0"] = "Mina",
    ["North_Las_Vegas"] = "North Las Vegas",
    ["Pahute_Mesa_Airstrip"] = "Pahute Mesa",
    ["Tonopah_Airport"] = "Tonopah",
    ["Tonopah_Test_Range_Airfield"] = "Tonopah Test Range",
    }

do
    -- Configure SRS
    srs_path = "E:\\DCS-SimpleRadio-Standalone\\"
    --srs_path = "C:\\Progra~1\\DCS-SimpleRadio-Standalone\\"
    sound_file_path = "C:\\Users\\Jeff\\Saved Games\\DCS.openbeta_server\\Missions\\MOOSE_SOUND-1.0\\ATIS\\ATIS Soundfiles\\"
    -- Boulder AFB
    atisBoulder=ATIS:New(AIRBASE.Nevada.Boulder_City_Airport, 118.475)
        :SetSRS(srs_path, "female", "en-US")
        --:SetSoundfilesPath(sound_file_path)
        :SetTowerFrequencies({122.7})
        --:Start()
     --   SCHEDULER:New( nil, function() atisBoulder:Start() end, {}, 60 )

    -- Creech AFB
    atisCreech=ATIS:New(AIRBASE.Nevada.Creech_AFB, 290.450)
        :SetSRS(srs_path, "female", "en-US")
        --:SetSoundfilesPath(sound_file_path)
        :SetTowerFrequencies({360.625, 118.300})
        --:__Start(15)

    --    SCHEDULER:New( nil, function() atisCreech:Start() end, {}, 75 )

    -- Hendersen Executive Airport
    atisHendersen=ATIS:New(AIRBASE.Nevada.Henderson_Executive_Airport, 120.775)
        :SetSRS(srs_path, "female", "en-US")
        --:SetSoundfilesPath(sound_file_path)
        :SetTowerFrequencies({125.100})
        --:__Start(30)

     --   SCHEDULER:New( nil, function() atisHendersen:Start() end, {}, 90 )

    -- Laughlin Airport
    atisLaughlin=ATIS:New(AIRBASE.Nevada.Laughlin_Airport, 119.825)
        :SetSRS(srs_path, "female", "en-US")
        --:SetSoundfilesPath(sound_file_path)
        :SetTowerFrequencies({123.9})
        --:__Start(45)

     --   SCHEDULER:New( nil, function() atisLaughlin:Start() end, {}, 105 )

    --McCarran Intl/Harry Reid
    atisMcCarran=ATIS:New(AIRBASE.Nevada.McCarran_International_Airport, 132.400)
        :SetSRS(srs_path, "female", "en-US")
        --SetSoundfilesPath(sound_file_path)
        :SetTowerFrequencies({257.800, 119.900})
        --:__Start(60)

     --   SCHEDULER:New( nil, function() atisMcCarran:Start() end, {}, 120 )

    -- Nellis AFB
    atisNellis=ATIS:New(AIRBASE.Nevada.Nellis_AFB, 270.1)
        :SetSRS(srs_path, "female", "en-US")
        --:SetSoundfilesPath(sound_file_path)
        :SetActiveRunway("21L")
        :SetTowerFrequencies({327.000, 132.550})
        :SetTACAN(12)
        :AddILS(109.1, "21L")
        :Start()
        --SCHEDULER:New( nil, function() atisNellis:Start() end, {}, 135 )

    -- North Las Vegas
    atisNLV=ATIS:New(AIRBASE.Nevada.North_Las_Vegas, 118.050)
        :SetSRS(srs_path, "female", "en-US")
        --:SetSoundfilesPath(sound_file_path)
        :SetTowerFrequencies({360.750, 125.700})
        --:__Start(90)

        --SCHEDULER:New( nil, function() atisNLV:Start() end, {}, 150 )

    -- Tonopah Test Range Airfield
    atisTonopah=ATIS:New(AIRBASE.Nevada.Tonopah_Test_Range_Airfield, 118.100)
        :SetSRS(srs_path, "female", "en-US")
        --:SetSoundfilesPath(sound_file_path)
        :SetTowerFrequencies({257.950, 124.750})
        --:__Start(105)

     --   SCHEDULER:New( nil, function() atisTonopah:Start() end, {}, 165 )

end
