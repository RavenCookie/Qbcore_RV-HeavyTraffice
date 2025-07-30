Config = {}

-- Enable or disable the script
Config.Enabled = true

-- Default traffic density multiplier (1.0 is default game setting)
Config.DefaultTrafficDensity = 3.0
Config.NightTrafficDensity = 1.5 -- Lower traffic at night
Config.DayTrafficDensity = 3.0 -- Higher traffic during day

-- Default pedestrian density multiplier
Config.DefaultPedestrianDensity = 2.0
Config.NightPedestrianDensity = 0.8
Config.DayPedestrianDensity = 2.0

-- Parked vehicle density multiplier
Config.ParkedVehicleDensity = 1.5

-- Random vehicle density multiplier
Config.RandomVehicleDensity = 2.5

-- Areas with special traffic density settings
Config.Areas = {
    ["downtown"] = {
        coords = vector3(-200.0, -800.0, 30.0), -- Downtown area
        radius = 800.0,
        trafficDensity = 4.0,
        pedestrianDensity = 3.0,
        updateInterval = 1000, -- ms
        allowRandomVehicles = true,
        allowParkedVehicles = true,
        active = true
    },
    ["highway"] = {
        coords = vector3(1500.0, 800.0, 75.0), -- Highway area
        radius = 1200.0,
        trafficDensity = 5.0,
        pedestrianDensity = 0.5,
        updateInterval = 800,
        allowRandomVehicles = true,
        allowParkedVehicles = false,
        active = true
    },
    ["countryside"] = {
        coords = vector3(2500.0, 4800.0, 35.0), -- Countryside area
        radius = 2000.0,
        trafficDensity = 1.0,
        pedestrianDensity = 0.3,
        updateInterval = 2000,
        allowRandomVehicles = false,
        allowParkedVehicles = false,
        active = true
    }

}

-- Command for admins to toggle the script
Config.AdminCommand = "toggletraffic"
Config.SetTrafficCommand = "settraffic"
Config.SetPedestrianCommand = "setpedestrian"
Config.SetIntervalCommand = "setinterval"
Config.StatusCommand = "trafficstatus"

-- Whether to allow parked emergency vehicles globally
Config.AllowParkedEmergencyVehicles = true

-- Time (in ms) between traffic density updates (default, can be overridden per area)
Config.UpdateInterval = 1000
