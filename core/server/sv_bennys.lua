MRP_SERVER = nil

TriggerEvent('mrp:getSharedObject', function(obj) MRP_SERVER = obj end)

local repairCost = vehicleBaseRepairCost

RegisterServerEvent('mrp_lscustoms:attemptPurchase')
AddEventHandler('mrp_lscustoms:attemptPurchase', function(cheap, type, upgradeLevel)
	local src = source
	local char = MRP_SERVER.getSpawnedCharacter(src)
    if type == "repair" then
        if char.stats.cash >= repairCost then
            TriggerEvent('mrp:bankin:server:pay:cash', source, repairCost)
            TriggerClientEvent('mrp_lscustoms:purchaseSuccessful', source)
        else
            TriggerClientEvent('mrp_lscustoms:purchaseFailed', source)
        end
    elseif type == "performance" then
        if char.stats.cash >= vehicleCustomisationPrices[type].prices[upgradeLevel] then
            TriggerClientEvent('mrp_lscustoms:purchaseSuccessful', source)
            TriggerEvent('mrp:bankin:server:pay:cash', source, vehicleCustomisationPrices[type].prices[upgradeLevel])
        else
            TriggerClientEvent('mrp_lscustoms:purchaseFailed', source)
        end
    else
        if char.stats.cash >= vehicleCustomisationPrices[type].price then
            TriggerClientEvent('mrp_lscustoms:purchaseSuccessful', source)
            TriggerEvent('mrp:bankin:server:pay:cash', source, vehicleCustomisationPrices[type].price)
        else
            TriggerClientEvent('mrp_lscustoms:purchaseFailed', source)
        end
    end
end)

RegisterServerEvent('mrp_lscustoms:updateRepairCost')
AddEventHandler('mrp_lscustoms:updateRepairCost', function(cost)
    repairCost = cost
end)