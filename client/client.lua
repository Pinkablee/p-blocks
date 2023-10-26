-- Function to draw text on screen
local function DrawTextOnScreen(message, x, y, r, g, b, a, font, scale, shadow, outline)
    SetTextFont(font)
    SetTextScale(0.0, scale)
    SetTextCentre(false)
    SetTextColour(r, g, b, a)
    SetTextOutline()
    SetTextEntry('STRING')
    AddTextComponentString(message)
    DrawText(x, y)
end

-- Function to add blip for radius
local function AddRadiusBlip(coords, radius, color)
    local handler = AddBlipForRadius(coords.x, coords.y, coords.z, radius)
    SetBlipSprite(handler, 1)
    SetBlipAlpha(handler, 100)
    SetBlipColour(handler, color)
end

-- Function to add blip for zone
local function AddZoneBlip(coords, zoneSize, blipSprite, blipColor, blipLabel)
    local blip = AddBlipForCoord(coords.x, coords.y, coords.z)
    SetBlipSprite(blip, blipSprite)
    SetBlipDisplay(blip, 4)
    SetBlipScale(blip, 0.45)
    SetBlipColour(blip, blipColor)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName('STRING')
    AddTextComponentString(blipLabel)
    EndTextCommandSetBlipName(blip)
end

-- Function to check if inside zone
local function IsInsideZone(coords, zoneCoords, zoneSize)
    return #(coords - zoneCoords) < zoneSize
end

CreateThread(function()
    for k, v in pairs(cfg.blocks) do
        AddRadiusBlip(v.coords, v.radius + tonumber(0.0), v.color)
    end
end)

CreateThread(function()
    for k, v in pairs(cfg.blocks) do
        AddZoneBlip(v.coords, v.zoneSize, v.blipSprite, v.blipColor, v.blipLabel)
    end
end)

CreateThread(function()
    while true do
        local sleep = 1600
        local coords = GetEntityCoords(cache.ped)

        for k, v in pairs(cfg.blocks) do
            if IsInsideZone(coords, v.coords, v.zoneSize) then
                sleep = 1
                DrawTextOnScreen(v.label, 0.40, 0.01, 255, 255, 255, 255, 6, 0.5, true, false)
                DrawMarker(1, v.coords.x, v.coords.y, v.coords.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 80.0, 80.0, 75.0, v.markerColor.r, v.markerColor.g, v.markerColor.b, 100, false, false, 2, false, nil, nil, false)
                break
            end
        end

        Wait(sleep)
    end
end)
