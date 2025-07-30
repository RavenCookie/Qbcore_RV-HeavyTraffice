local QBCore = exports['qb-core']:GetCoreObject()
local isActive = Config.Enabled
local lastArea = nil
local lastDensity = nil
local lastPedDensity = nil
local lastUpdate = 0

-- Utility: get current hour
local function GetHour()
    return GetClockHours()
end

-- Function to set traffic density
local function SetTrafficDensity(trafficMultiplier, pedMultiplier, parkedMultiplier, randomMultiplier, allowRandom, allowParked)
    if allowParked == false then parkedMultiplier = 0.0 end
    if allowRandom == false then randomMultiplier = 0.0 end
    SetParkedVehicleDensityMultiplierThisFrame(parkedMultiplier)
    SetVehicleDensityMultiplierThisFrame(trafficMultiplier)
    SetPedDensityMultiplierThisFrame(pedMultiplier)
    SetRandomVehicleDensityMultiplierThisFrame(randomMultiplier)
    SetScenarioPedDensityMultiplierThisFrame(pedMultiplier, pedMultiplier)
    if not Config.AllowParkedEmergencyVehicles then
        SetParkedVehicleDensityMultiplierThisFrame(0.0)
    end
end

-- Function to check if player is in a special area
local function IsPlayerInArea()
    local playerCoords = GetEntityCoords(PlayerPedId())
    for areaName, area in pairs(Config.Areas) do
        if area.active then
            local distance = #(playerCoords - area.coords)
            if distance < area.radius then
                return true, areaName
            end
        end
    end
    return false, nil
end

-- Main thread to manage traffic density
CreateThread(function()
    while true do
        if isActive then
            local inArea, areaName = IsPlayerInArea()
            local hour = GetHour()
            local isNight = (hour < 7 or hour > 20)
            local updateInterval = Config.UpdateInterval
            local trafficDensity, pedDensity, allowRandom, allowParked
            if inArea and areaName then
                local area = Config.Areas[areaName]
                trafficDensity = area.trafficDensity
                pedDensity = area.pedestrianDensity
                allowRandom = area.allowRandomVehicles
                allowParked = area.allowParkedVehicles
                updateInterval = area.updateInterval or Config.UpdateInterval
            else
                trafficDensity = isNight and (Config.NightTrafficDensity or Config.DefaultTrafficDensity) or (Config.DayTrafficDensity or Config.DefaultTrafficDensity)
                pedDensity = isNight and (Config.NightPedestrianDensity or Config.DefaultPedestrianDensity) or (Config.DayPedestrianDensity or Config.DefaultPedestrianDensity)
                allowRandom = true
                allowParked = true
            end
            -- Only update if values changed or enough time passed
            if lastArea ~= areaName or lastDensity ~= trafficDensity or lastPedDensity ~= pedDensity or (GetGameTimer() - lastUpdate) > updateInterval then
                SetTrafficDensity(
                    trafficDensity,
                    pedDensity,
                    Config.ParkedVehicleDensity,
                    Config.RandomVehicleDensity,
                    allowRandom,
                    allowParked
                )
                lastArea = areaName
                lastDensity = trafficDensity
                lastPedDensity = pedDensity
                lastUpdate = GetGameTimer()
            end
            Wait(updateInterval)
        else
            Wait(1500)
        end
    end
end)

-- Register event to toggle the system
RegisterNetEvent('rv-heavytraffic:client:toggle', function()
    isActive = not isActive
    local status = isActive and "enabled" or "disabled"
    QBCore.Functions.Notify("Heavy traffic system " .. status, "primary", 3000)
end)

-- Update settings when config is changed by server
RegisterNetEvent('rv-heavytraffic:client:updateConfig', function(newConfig)
    Config = newConfig
    QBCore.Functions.Notify("Traffic settings updated", "success", 3000)
end)
