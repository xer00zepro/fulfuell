RegisterCommand('fullfuel', function(source, args, rawCommand)
  local player = GetPlayerPed(source)
  
  -- Vérifie si le joueur a la permission nécessaire
  TriggerServerEvent('checkPermission', source, "fullfuel.command")
end, false)

-- Événement déclenché côté serveur pour vérifier les autorisations du joueur
RegisterNetEvent('permissionChecked')
AddEventHandler('permissionChecked', function(allowed)
  local source = source
  if allowed then
    -- Donne le plein d'essence au véhicule
    if IsPedInAnyVehicle(player, false) then
      local vehicle = GetVehiclePedIsIn(player, false)
      SetVehicleFuelLevel(vehicle, 100.0)
      TriggerClientEvent('chat:addMessage', -1, { args = { '^5SYSTEM', 'Le véhicule a été rempli d\'essence!' } })
    else
      TriggerClientEvent('chat:addMessage', source, { args = { '^1ERREUR', 'Vous devez être dans un véhicule pour utiliser cette commande.' } })
    end
  else
    TriggerClientEvent('chat:addMessage', source, { args = { '^1ERREUR', 'Vous n\'avez pas les autorisations nécessaires pour utiliser cette commande.' } })
  end
end)
