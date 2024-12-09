RegisterNetEvent("shop_23859238", function(data)
    local src = source;
    local xPlayer = ESX.GetPlayerFromId(src);
    local check = true;

    for k, v in pairs(Config.Position) do 
        if (#(xPlayer.getCoords(true) - v.pos) < 20) then 
            check = false;
        end
    end
    if (check) then 
        xPlayer.showNotification("+1")
        -- DropPlayer(src, "¨+1")
    end

    if (xPlayer.getAccount(Config.Money).money >= data.prix) then
        xPlayer.addInventoryItem(weapons, 1, 1)
        xPlayer.removeAccountMoney(Config.Money, data.prix);
    end
end)

