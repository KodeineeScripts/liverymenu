local QBCore = exports['qb-core']:GetCoreObject()

local function notify(text)
    QBCore.Functions.Notify(text, "error")
end

local function openLiveryMenu()
    local ped = PlayerPedId()
    local veh = GetVehiclePedIsIn(ped, false)

    if veh == 0 then
        notify("You must be inside a vehicle to use the livery menu.")
        return
    end

    local liveryCount = GetVehicleLiveryCount(veh)
    if liveryCount == 0 then
        notify("This vehicle has no liveries available.")
        return
    end

    local menuItems = {
        { header = "Livery Menu", isMenuHeader = true }
    }

    for i = 0, liveryCount - 1 do
        table.insert(menuItems, {
            header = "Livery " .. (i + 1),
            txt = "",
            params = {
                event = "kodeinee-liverymenu:setLivery",
                args = i
            }
        })
    end

    table.insert(menuItems, {
        header = "Close",
        txt = "",
        params = {
            event = "qb-menu:closeMenu"
        }
    })

    exports['qb-menu']:openMenu(menuItems)
end

RegisterCommand("liverymenu", function()
    openLiveryMenu()
end)

RegisterNetEvent("kodeinee-liverymenu:setLivery", function(liveryIndex)
    local ped = PlayerPedId()
    local veh = GetVehiclePedIsIn(ped, false)

    if veh ~= 0 then
        SetVehicleLivery(veh, liveryIndex)
        QBCore.Functions.Notify("Livery set to " .. (liveryIndex + 1), "success")
    else
        notify("You must be inside a vehicle to set a livery.")
    end
end)
