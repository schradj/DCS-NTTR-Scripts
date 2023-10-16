MSRS_BLACKJACK = MSRS:New(srs_path, 377.8)
MSRS_BLACKJACK:SetLabel("BLACKJACK")
MSRS_BLACKJACK:SetCoalition(coalition.side.BLUE)
--MSRS_BLACKJACK:SetCoordinate(COORDINATE:NewFromVec2(-00397034, -00017414))
MSRSQ_BLACKJACK = MSRSQUEUE:New("BLACKJACK")

MENU_BLACKJACK = MENU_COALITION:New(coalition.side.BLUE, "BLACKJACK")

function activateRange(range, group_prefixes)
    local set_grp = SET_GROUP:New():FilterPrefixes(group_prefixes):FilterOnce()
    set_grp:Activate()
    set_grp:ForEachGroup( 
        function (grp)
            grp:SetAIOnOff(false)
        end
    )

    range:Start()
    local clients_active = SET_CLIENT:New():FilterActive():FilterCoalitions("blue"):FilterOnce()
    clients_active:ForEachClient(
        function (Client)
            local _playername = Client:GetPlayer()
            local _unitName = Client.ClientName
            local _unit = Client:GetClientGroupUnit()
            local _unitType = _unit:GetTypeName()
            local _uid = _unit:GetID()
            local _group = _unit:GetGroup()
            local _gid = _group:GetID()
            local _callsign = _unit:GetCallsign()
        
            -- Debug output.
            local text = string.format( "Player %s, callsign %s entered unit %s (UID %d) of group %s (GID %d)", _playername, _callsign, _unitName, _uid, _group:GetName(), _gid )
            range:T( range.id .. text )
        
            -- Reset current strafe status.
            range.strafeStatus[_uid] = nil
        
            -- Add Menu commands after a delay of 0.1 seconds.
            range:ScheduleOnce( 0.1, range._AddF10Commands, range, _unitName )
        
            -- By default, some bomb impact points and do not flare each hit on target.
            range.PlayerSettings[_playername] = {} -- #RANGE.PlayerData
            range.PlayerSettings[_playername].smokebombimpact = range.defaultsmokebomb
            range.PlayerSettings[_playername].flaredirecthits = false
            range.PlayerSettings[_playername].smokecolor = SMOKECOLOR.Blue
            range.PlayerSettings[_playername].flarecolor = FLARECOLOR.Red
            range.PlayerSettings[_playername].delaysmoke = true
            range.PlayerSettings[_playername].messages = true
            range.PlayerSettings[_playername].client = CLIENT:FindByName( _unitName, nil, true )
            range.PlayerSettings[_playername].unitname = _unitName
            range.PlayerSettings[_playername].playername = _playername
            range.PlayerSettings[_playername].airframe = _unitType
            range.PlayerSettings[_playername].inzone = false
        
            -- Start check in zone timer.
            if range.planes[_uid] ~= true then
              range.timerCheckZone = TIMER:New( range._CheckInZone, range, _unitName ):Start( 1, 1 )
              range.planes[_uid] = true
            end
        end
      )

end

MENU_BLACKJACK_Bomb_Rngs = MENU_COALITION:New(coalition.side.BLUE, "Bombing Ranges",MENU_BLACKJACK)


do -- BLACKJACK Maker Delete Mission Launcher
    EVENTHANDLER_BLACKJACK = EVENTHANDLER:New()
    EVENTHANDLER_BLACKJACK:HandleEvent(EVENTS.MarkRemoved)

    --- @param Core.Event#EVENT self
    -- @param Core.Event#EVENTDATA EventData
    function EVENTHANDLER_BLACKJACK:OnEventMarkRemoved( EventData )
        if (string.find(EventData.MarkText, "^BLKJACK")) ~= nil then
            -- Debug info.
            local text = string.format( "Captured event MarkRemoved for myself:\n" )
            text = text .. string.format( "Marker ID  = %s\n", tostring( EventData.MarkID ) )
            text = text .. string.format( "Coalition  = %s\n", tostring( EventData.MarkCoalition ) )
            text = text .. string.format( "Group  ID  = %s\n", tostring( EventData.MarkGroupID ) )
            text = text .. string.format( "Initiator  = %s\n", EventData.IniUnit and EventData.IniUnit:GetName() or "Nobody" )
            text = text .. string.format( "Coordinate = %s\n", EventData.MarkCoordinate and EventData.MarkCoordinate:ToStringLLDMS() or "Nowhere" )
            text = text .. string.format( "Text:          \n%s", tostring( EventData.MarkText ) )
            self:T2( text )
            ---local UNIT_requester = UNIT:FindByName(EventData.IniUnit:GetName())
            local GROUP_requester = GROUP:FindByName(EventData.MarkGroupID)
            _, _, msn = string.find(EventData.MarkText, "BLKJACK%s+(%a+)") 
            if (string.find(msn, "^JAM") ~= nil) then
                _, _, msn, hdng, alt = string.find(EventData.MarkText, "BLKJACK%s+(%a+)%s+(%a+)%s+(%a+)") 
                launch_Growler(EventData.MarkCoordinate, hdng, alt, GROUP_requester)
            end
        end
    end
end 