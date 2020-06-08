ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('castro:coletar') 
AddEventHandler('castro:coletar', function(v)
	local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local frutas = xPlayer.getInventoryItem(v.item).count
    if frutas < 51 then
        xPlayer.addInventoryItem(v.item, math.random(1,5))
		Citizen.Wait(1000)
		xPlayer.addInventoryItem(v.item, math.random(1,5))
    else 
		TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Não podes levar mais dessa fruta!', length = 2500, style = { ['background-color'] = '#ff0000', ['color'] = '#ffffff' } })
    end
end)

RegisterServerEvent('castro:processo')
AddEventHandler('castro:processo', function(v)
	local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local fruta = xPlayer.getInventoryItem(v.item).count
    if fruta >= 10 then
		TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Estás a colocar Fruta na caixa!', length = 2500, style = { ['background-color'] = '#0050e6', ['color'] = '#ffffff' } })
        xPlayer.removeInventoryItem(v.item, 10)
        xPlayer.addMoney(v.price)
		TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Recebeste '..v.price..'€ pela Fruta!', length = 2500, style = { ['background-color'] = '#00ff22', ['color'] = '#ffffff' } })
    else
		TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Tens de ter no minimo 10 Peças da mesma Fruta!', length = 2500, style = { ['background-color'] = '#ff0000', ['color'] = '#ffffff' } })
	end   
end)

RegisterServerEvent('castro:embalamento')
AddEventHandler('castro:embalamento', function(v)
	local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local frutex = xPlayer.getInventoryItem(v.item).count
    if frutex >=10 then
    xPlayer.removeInventoryItem(v.item, 10)
    xPlayer.addInventoryItem(v.recompensa, 1)
    TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Embalaste Fruta com sucesso', length = 2500, style = { ['background-color'] = '#00ff22', ['color'] = '#ffffff' } })
else
	TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Tens de ter no minimo 10 Peças da mesma Fruta!', length = 2500, style = { ['background-color'] = '#ff0000', ['color'] = '#ffffff' } })

end
end)

