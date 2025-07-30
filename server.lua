
local QBCore = exports['qb-core']:GetCoreObject()

local function isAdmin(src)
    return QBCore.Functions.HasPermission(src, 'admin') or QBCore.Functions.HasPermission(src, 'god')
end

-- Command to toggle traffic system
QBCore.Commands.Add(Config.AdminCommand, 'Toggle heavy traffic system', {}, false, function(source)
    if isAdmin(source) then
        TriggerClientEvent('rv-heavytraffic:client:toggle', source)
        TriggerClientEvent('QBCore:Notify', source, 'Heavy traffic system toggled.', 'success')
    else
        TriggerClientEvent('QBCore:Notify', source, 'You don\'t have permission for this!', 'error')
    end
end)

-- Command to update traffic density in an area
QBCore.Commands.Add(Config.SetTrafficCommand, 'Set traffic density for an area (Admin Only)', {
    {name = 'area', help = 'Area name (downtown, highway, countryside)'},
    {name = 'density', help = 'Traffic density multiplier (0.0-5.0)'}
}, false, function(source, args)
    if isAdmin(source) then
        local area = args[1]
        local density = tonumber(args[2])
        if area and density and Config.Areas[area] and density >= 0.0 and density <= 5.0 then
            Config.Areas[area].trafficDensity = density
            TriggerClientEvent('rv-heavytraffic:client:updateConfig', -1, Config)
            TriggerClientEvent('QBCore:Notify', source, 'Traffic density for ' .. area .. ' set to ' .. density, 'success')
        else
            TriggerClientEvent('QBCore:Notify', source, 'Invalid area or density value!', 'error')
        end
    else
        TriggerClientEvent('QBCore:Notify', source, 'You don\'t have permission for this!', 'error')
    end
end)

-- Command to update pedestrian density in an area
QBCore.Commands.Add(Config.SetPedestrianCommand, 'Set pedestrian density for an area (Admin Only)', {
    {name = 'area', help = 'Area name (downtown, highway, countryside)'},
    {name = 'density', help = 'Pedestrian density multiplier (0.0-5.0)'}
}, false, function(source, args)
    if isAdmin(source) then
        local area = args[1]
        local density = tonumber(args[2])
        if area and density and Config.Areas[area] and density >= 0.0 and density <= 5.0 then
            Config.Areas[area].pedestrianDensity = density
            TriggerClientEvent('rv-heavytraffic:client:updateConfig', -1, Config)
            TriggerClientEvent('QBCore:Notify', source, 'Pedestrian density for ' .. area .. ' set to ' .. density, 'success')
        else
            TriggerClientEvent('QBCore:Notify', source, 'Invalid area or density value!', 'error')
        end
    else
        TriggerClientEvent('QBCore:Notify', source, 'You don\'t have permission for this!', 'error')
    end
end)

-- Command to update updateInterval in an area
QBCore.Commands.Add(Config.SetIntervalCommand, 'Set update interval for an area (Admin Only)', {
    {name = 'area', help = 'Area name (downtown, highway, countryside)'},
    {name = 'interval', help = 'Update interval in ms (e.g. 1000)'}
}, false, function(source, args)
    if isAdmin(source) then
        local area = args[1]
        local interval = tonumber(args[2])
        if area and interval and Config.Areas[area] and interval >= 100 and interval <= 10000 then
            Config.Areas[area].updateInterval = interval
            TriggerClientEvent('rv-heavytraffic:client:updateConfig', -1, Config)
            TriggerClientEvent('QBCore:Notify', source, 'Update interval for ' .. area .. ' set to ' .. interval .. ' ms', 'success')
        else
            TriggerClientEvent('QBCore:Notify', source, 'Invalid area or interval value!', 'error')
        end
    else
        TriggerClientEvent('QBCore:Notify', source, 'You don\'t have permission for this!', 'error')
    end
end)

-- Command to show current traffic settings
QBCore.Commands.Add(Config.StatusCommand, 'Show current traffic settings', {}, false, function(source)
    if isAdmin(source) then
        local msg = 'Current Traffic Settings:\n'
        for area, data in pairs(Config.Areas) do
            msg = msg .. (area .. ': Traffic=' .. data.trafficDensity .. ', Ped=' .. data.pedestrianDensity .. ', Interval=' .. (data.updateInterval or Config.UpdateInterval) .. 'ms\n')
        end
        TriggerClientEvent('QBCore:Notify', source, msg, 'primary', 8000)
    else
        TriggerClientEvent('QBCore:Notify', source, 'You don\'t have permission for this!', 'error')
    end
end)

-- Print a message when the resource starts
AddEventHandler('onResourceStart', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then
        return
    end
    print('Resource ' .. resourceName .. ' started successfully')
    print('Heavy Traffic Script by Raven (Enhanced)')
end)
