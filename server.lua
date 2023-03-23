local ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('fichas:comprar')
AddEventHandler('fichas:comprar', function(cantidad)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    local precioPorFicha = Config.PrecioFicha
    local totalCosto = precioPorFicha * cantidad
    local playerMoney = xPlayer.getAccount('money').money

    if playerMoney >= totalCosto then
        xPlayer.removeAccountMoney('money', totalCosto)
        xPlayer.addAccountMoney('fichas', cantidad)
        TriggerClientEvent('esx:showNotification', _source, 'Has comprado ' .. cantidad .. ' fichas por $' .. totalCosto)
    else
        TriggerClientEvent('esx:showNotification', _source, 'No tienes suficiente dinero')
    end
end)

RegisterServerEvent('fichas:vender')
AddEventHandler('fichas:vender', function(cantidad)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    local precioPorFicha = Config.PrecioFicha
    local totalCosto = precioPorFicha * cantidad
    local playerFichas = xPlayer.getAccount('fichas').money

    if playerFichas >= cantidad then
        xPlayer.removeAccountMoney('fichas', cantidad)
        xPlayer.addAccountMoney('money', totalCosto)
        TriggerClientEvent('esx:showNotification', _source, 'Has vendido ' .. cantidad .. ' fichas por $' .. totalCosto)
    else
        TriggerClientEvent('esx:showNotification', _source, 'No tienes suficientes fichas')
    end
end)
