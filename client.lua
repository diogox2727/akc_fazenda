local Keys = {
    ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
    ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
    ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
    ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
    ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
    ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
    ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
    ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
    ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

ESX                             = nil
local PlayerData                = {}
local incollect                 = false

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    PlayerData = xPlayer
end)

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

Citizen.CreateThread(function()
    while true do
        Wait(0)
		local coords = GetEntityCoords(GetPlayerPed(-1))
		for k,v in pairs(Config.Zone) do
			if (GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 1.0) then
				DrawText3D(v.x, v.y, v.z, '~g~[E] ~w~Apanhar '..v.label, 0.4)
					if (GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 1.0) then
						if IsControlJustReleased(0, Keys['E']) then
							if incollect == false then
								collect(v)
							end
						end
					end
			end
		end
    end
end)

Citizen.CreateThread(function()
    while true do
        Wait(0)
		local coords = GetEntityCoords(GetPlayerPed(-1))
		for k,v in pairs(Config.Vendas) do
			if (GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 1.0) then
				DrawText3D(v.x, v.y, v.z, '~g~[E] ~w~Vender '..v.label, 0.4)
					if (GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 1.0) then
						if IsControlJustReleased(0, Keys['E']) then
							if incollect == false then
								sell(v)
							end
						end
					end
			end
		end
    end
end)

Citizen.CreateThread(function()
	while true do
		Wait(0)
		local coords = GetEntityCoords(GetPlayerPed(-1))
		for k,v in pairs(Config.Embalos) do
			if (GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 1.0) then
				DrawText3D(v.x, v.y, v.z, '~g~[E] ~w~Embalar '..v.label, 0.4)
					if (GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 1.0) then
						if IsControlJustReleased(0, Keys['E']) then
							embalamento(v)
						end
					end
			end

		end
	end
end)

function collect(v)
	anim(v)
    TriggerServerEvent('castro:coletar', v)
    exports['mythic_notify']:SendAlert('inform', 'Apanhando Fruta')
    incollect = true
    Citizen.Wait(5500)
    incollect = false
end

function embalamento(v)
	anim(v)
	exports['mythic_notify']:SendAlert('inform', 'Estás a embalar a Fruta')
	Citizen.Wait(2000)
	TriggerServerEvent('castro:embalamento', v)
	
end

function sell(v)
	anim(v)
    TriggerServerEvent('castro:processo', v)
    incollect = true
    Citizen.Wait(1000)
    incollect = false
end

function anim(v)
	local lib, anim = v.lib, v.anim
    ESX.Streaming.RequestAnimDict(lib, function()
        TaskPlayAnim(PlayerPedId(), lib, anim, 1.0, -3.0, 5000, 0, 0, false, false, false)
    end)
end

function DrawText3D(x, y, z, text, scale)
local onScreen, _x, _y = World3dToScreen2d(x, y, z)
	local pX, pY, pZ = table.unpack(GetGameplayCamCoords())
	SetTextScale(scale, scale)
	SetTextFont(4)
	SetTextProportional(1)
	SetTextEntry("STRING")
	SetTextCentre(1)
	SetTextColour(255, 255, 255, 255)
	SetTextOutline()
	AddTextComponentString(text)
	DrawText(_x, _y)
    local factor = (string.len(text)) / 370
    DrawRect(_x, _y + 0.0125, 0.015 + factor, 0.03, 41, 11, 41, 90)
end

Citizen.CreateThread(function()
    local blip = AddBlipForCoord(403.83, 6491.18, 00.000) 
    SetBlipSprite(blip, 557)
    SetBlipDisplay(blip, 4)
    SetBlipScale (blip, 0.7)
    SetBlipColour(blip, 28)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString('Fazenda')
    EndTextCommandSetBlipName(blip)
end)
