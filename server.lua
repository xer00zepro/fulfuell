-- Événement qui est déclenché lorsque la commande est exécutée
RegisterCommand('fullfuel', function(source, args)
	-- Obtenez l'ID du joueur qui a exécuté la commande
	local playerId = source

	-- Vérifiez si le joueur est un modérateur
	if IsPlayerAllowed(playerId) then
		-- Déclenchez l'événement pour remplir le réservoir de carburant
		TriggerClientEvent('permissionChecked', playerId)
	else
		-- Le joueur n'a pas les permissions nécessaires pour utiliser cette commande
		TriggerClientEvent('permissionChecked', playerId, "^1Erreur: Vous n'êtes pas autorisé à utiliser cette commande.")
	end
end, false)

-- Liste des groupes de joueurs autorisés
local allowedGroups = {
--'user',
    'admin',
    'superadmin',
    'moderator'
}

-- Vérifie si le joueur a la permission
function IsPlayerAllowed(player)
    for _,group in ipairs(allowedGroups) do
        if IsPlayerAceAllowed(player, 'group.' .. group) then
            return true
        end
    end
    return false
end

-- Définir les autorisations pour la commande 'fullfuel'
AddEventHandler('onServerResourceStart', function(resourceName)
	if (GetCurrentResourceName() ~= resourceName) then
		return
	end

	-- Définir l'autorisation pour la commande 'fullfuel'
	ExecuteCommand('remove_principal allow', 'fullfuel.command')
	for _,group in ipairs(allowedGroups) do
		ExecuteCommand('add_principal group.' .. group .. ' allow', 'fullfuel.command')
	end
end)
