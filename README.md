
# rv-heavytraffic

A QBCore heavy traffic script that allows server administrators to control traffic and pedestrian density in different areas of the city, with advanced configuration and admin tools.

## Author
Raven

## Features
- Increase or decrease traffic and pedestrian density globally or per-area
- Night/Day multipliers for more realistic city behavior
- Configure special areas with unique traffic, pedestrian, and update interval settings
- Enable/disable random and parked vehicles per area
- Performance-friendly: dynamic update intervals and reduced unnecessary updates
- Admin commands to toggle, configure, and view the system

## Installation
1. Place the folder in your server's resources directory
2. Add `ensure rv-heavytraffic` to your server.cfg
3. Configure the script to your liking in `config.lua`
4. Restart your server or start the resource

## Admin Commands
- `/toggletraffic` - Toggles the traffic system on/off (admin only)
- `/settraffic [area] [density]` - Set traffic density for a specific area (admin only)
  - Example: `/settraffic downtown 3.0`
- `/setpedestrian [area] [density]` - Set pedestrian density for a specific area (admin only)
  - Example: `/setpedestrian highway 0.5`
- `/setinterval [area] [ms]` - Set update interval (in ms) for a specific area (admin only)
  - Example: `/setinterval countryside 2000`
- `/trafficstatus` - Show current traffic and pedestrian settings (admin only)

## Configuration
You can customize the script by editing the `config.lua` file:
- Change default, night, and day traffic/pedestrian density
- Add or modify special areas with different traffic rules, update intervals, and vehicle toggles
- Adjust update intervals for performance optimization
- Configure admin commands

### Example Area Configuration
```
Config.Areas = {
    ["downtown"] = {
        coords = vector3(-200.0, -800.0, 30.0),
        radius = 800.0,
        trafficDensity = 4.0,
        pedestrianDensity = 3.0,
        updateInterval = 1000, -- ms
        allowRandomVehicles = true,
        allowParkedVehicles = true,
        active = true
    },
    ...
}
```

## Support
For support or feature requests, please contact the author.

## License
This resource is provided as-is with no warranty. You may use and modify this resource for your personal or commercial FiveM server.
