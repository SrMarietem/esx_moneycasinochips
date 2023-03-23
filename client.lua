local ESX = nil
local displayMarker = false
local menuOpen = false
local markerCoords = vector3(977.31, 40.21, 74.88) -- Reemplaza x, y, z con las coordenadas deseadas

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)

Citizen.CreateThread(function()
    while true do
        local sleep = 500
        local ped = PlayerPedId()
        local coords = GetEntityCoords(ped)

        if #(coords - markerCoords) < 50.0 then
            sleep = 5
            DrawMarker(1, markerCoords.x, markerCoords.y, markerCoords.z - 1, 0, 0, 0, 0, 0, 0, 1.5, 1.5, 1.5, 50, 255, 50, 100, false, false, 2, false, nil, nil, false)

            if #(coords - markerCoords) < 1.5 then
                displayMarker = true
				local playerPed = PlayerPedId()
				local playerX, playerY, playerZ = table.unpack(GetEntityCoords(playerPed))
				if not menuOpen then
				ESX.ShowFloatingHelpNotification("Presiona ~r~[E]~s~ para comprar o vender fichas.", vector3(playerX, playerY, playerZ+0.85))
                end
				if IsControlJustReleased(0, 38) then
                    OpenMenu()
                end
            else
                if displayMarker then
                    displayMarker = false
                    ESX.UI.Menu.CloseAll()
                end
            end
        end
        Citizen.Wait(sleep)
    end
end)

function OpenMenu()
	menuOpen = true
	
    local elements = {
        { label = "Comprar fichas", value = "buy" },
        { label = "Vender fichas", value = "sell" },
    }

    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'main_menu', {
        title = "Fichas",
        align = "top-left",
        elements = elements
    }, function(data, menu)
        if data.current.value == "buy" then
            ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'buy_chips', {
                title = "Cantidad de fichas a comprar"
            }, function(data2, menu2)
                local amount = tonumber(data2.value)
                if amount == nil then
                    ESX.ShowNotification("Cantidad inválida")
                else
                    TriggerServerEvent("fichas:comprar", amount)
                    menu2.close()
                end
            end, function(_, menu2)
                menu2.close()
            end)
        elseif data.current.value == "sell" then
            ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'sell_chips', {
                title = "Cantidad de fichas a vender"
            }, function(data2, menu2)
                local amount = tonumber(data2.value)
                if amount == nil then
                    ESX.ShowNotification("Cantidad inválida")
                else
                    TriggerServerEvent("fichas:vender", amount)
                    menu2.close()
                end
            end, function(_, menu2)
                menu2.close()
            end)
        end
    end, function(_, menu)
        menu.close()
		menuOpen = false
    end)
end
