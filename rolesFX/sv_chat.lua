local Owner = {}
local HeadAdmin = {}
local CommunityManager = {}
local Developer = {}
local Admin = {}
local ServerSupporter = {}
local ServerHelper = {}
local ELAS = {} 

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

AddEventHandler('chatMessage', function(Source, Name, Msg)
    args = stringsplit(Msg, " ")
    CancelEvent()
    if string.find(args[1], "/") then
        local cmd = args[1]
        table.remove(args, 1)
    else    
		local xPlayer = ESX.GetPlayerFromId(Source)	
        local player = GetPlayerIdentifiers(Source)[1]
		if xPlayer.job.name == 'police' then 
			TriggerClientEvent('chatMessage', -1, "^*^5 ΕΛ.ΑΣ ^r| ^*^0 "..Name..": " , { 30, 30, 255 }, Msg)
			return
		end
		if xPlayer.job.name == 'ambulance' then 
			TriggerClientEvent('chatMessage', -1, "^*^3 ΕΚΑΒ ^r| ^*^0 "..Name..": " , { 30, 30, 255 }, Msg)
			return
		end
		if xPlayer.getGroup() ~= "user" then
			local hexcode = GetPlayerIdentifiers(Source)[1]
			local groupsLevel = MySQL.Sync.fetchAll('SELECT * FROM users WHERE identifier = @hexcode', {["@hexcode"] = hexcode})
			for k,v in pairs(groupsLevel) do
				if xPlayer.getGroup() == "mod" then
					if groupsLevel[k]["permission_level"] == 1 then
						TriggerClientEvent('chatMessage', -1, "^*^5 🔰Helper ^r| ^*^8 "..Name..": " , { 30, 30, 255 }, Msg)
                    elseif groupsLevel[k]["permission_level"] == 2 then
						TriggerClientEvent('chatMessage', -1, "^*^4 🔰Server Moderator ^r| ^*^8 "..Name..": " , { 30, 30, 255 }, Msg)
					end
                elseif xPlayer.getGroup() == "admin" then
                    if groupsLevel[k]["permission_level"] == 3 then
                        TriggerClientEvent('chatMessage', -1, "^*^2 🛡️Admin ^r| ^*^8 "..Name..": " , { 30, 30, 255 }, Msg)
					elseif groupsLevel[k]["permission_level"] == 4 then
						TriggerClientEvent('chatMessage', -1, "^*^1 🛡️Head Admin ^r| ^*^8 "..Name..": " , { 30, 30, 255 }, Msg)
					end
				else
					if xPlayer.getGroup() == "superadmin" then
						if groupsLevel[k]["permission_level"] == 5 then
							TriggerClientEvent('chatMessage', -1, "^*^3 👁️‍Community Supervisor ^r| ^*^8 "..Name..": " , { 30, 30, 255 }, Msg)
						elseif groupsLevel[k]["permission_level"] == 6 then
							TriggerClientEvent('chatMessage', -1, "^*^4 👷Staff Manager ^r| ^*^8 "..Name..": " , { 30, 30, 255 }, Msg)
						elseif groupsLevel[k]["permission_level"] == 7 then
							TriggerClientEvent('chatMessage', -1, "^*^9 🚗Vehicle Developer ^r| ^*^8 "..Name..": " , { 30, 30, 255 }, Msg)
						elseif groupsLevel[k]["permission_level"] == 8 then
							TriggerClientEvent('chatMessage', -1, "^*^5 ⛏️Server Developer ^r| ^*^8 "..Name..": " , { 30, 30, 255 }, Msg)
						elseif groupsLevel[k]["permission_level"] == 9 then
							TriggerClientEvent('chatMessage', -1, "^*^3 👑Co Owner ^r| ^*^8 "..Name..": " , { 30, 30, 255 }, Msg)
						elseif groupsLevel[k]["permission_level"] == 10 then
							TriggerClientEvent('chatMessage', -1, "^*^7 👑Owner ^r| ^*^8 "..Name..": " , { 30, 30, 255 }, Msg)
						else
							TriggerClientEvent('chatMessage', -1, "^*^1 Staff ^r| ^*^8 "..Name..": " , { 30, 30, 255 }, Msg)
						end
					end
				end
			end
		end  
    end
end)

function has_value (tab, val)
    for index, value in ipairs(tab) do
        if value == val then
            return true
        end
    end

    return false
end

function stringsplit(inputstr, sep)
    if sep == nil then
        sep = "%s"
    end
    local t={} ; i=1
    for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
        t[i] = str
        i = i + 1
    end
    return t
end