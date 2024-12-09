local isopen = false;

local function ShowHelpNotification(message, beep)
    if (beep==nil) then beep = true end
    AddTextEntry("esxHelpNotification", message)
    BeginTextCommandDisplayHelp("esxHelpNotification")
    EndTextCommandDisplayHelp(0, false, beep, -1)
end

local function Select(self, _, btn, PMenu, menuData, currentButton, currentBtn, currentSlt, result, slide)
    for k, v in pairs(Config.Shop) do 
        if (v.label == btn.name) then 
            TriggerServerEvent("shop_23859238", v);
        end
    end
end

menu = {};
menu.Base = { Header = {"commonmenu", "interaction_bgd"}, Color = {color_black}, HeaderColor = {50, 50, 50,}, Title = "Armurie"}
menu.Data = { currentMenu = "menu :"}
menu.Events = {onSelected = Select, onExited = function()
    isopen = false;
end}
menu.Menu = {
    ["menu :"] = {
        b = {
            {name = "Armes", ask = ">", askX = true},
            {name = "ArmesBlanche", ask = ">", askX = true},
            {name = "Autres", ask = ">", askX = true},
        }
    },
    ["armes"] = {
        b = function()
            local add = {};
            for k, v in pairs(Config.Shop) do 
                if (v.category == "armes") then 
                    add[#add+1] = {name = v.label, ask = "Prix : ~g~"..v.prix.."$", askX = true}
                end
            end
            return (add);
        end
    },
    ["armesblanche"] = {
        b = function()
            local add = {};
            for k, v in pairs(Config.Shop) do 
                if (v.category == "armesblanche") then 
                    add[#add+1] = {name = v.label, ask = "Prix : ~g~"..v.prix.."$", askX = true}
                end
            end
            return (add);
        end
    },
    ["autres"] = {
        b = function ()
            local add = {};
            for k, v in ipairs(Config.Shop) do
                if (v.category == "autres") then
                    add[#add+1] = {name = v.label, ask = "Prix : ~g~"..v.prix.."$", askX = true}
                end
            end
            return (add);
        end
    },
}

CreateThread(function()
    local ms = 0;
    while(function()
        ms = 1000;
        if (isopen) then return (true) end 
        for k, v in pairs(Config.Position) do
            if (#(GetEntityCoords(PlayerPedId()) - v.pos) <= 2) then 
                ms = 0;
                ShowHelpNotification("Appuie sur ~INPUT_CONTEXT~ pour ouvrir");
                if (IsControlJustPressed(1,51)) then 
                    isopen = true;
                    CreateMenu(menu);
                end
            end
        end
        return (true)
    end)() do Wait(ms) end
end)

Citizen.CreateThread(function()
    -- Position et modèle du ped
    local pedModel = "csb_thornton"  -- Modèle de ped criminel
    local pos = vector4(-513.74, -1039.30, 23.26, 281.70)  -- Position exacte

    -- Charger le modèle du ped
    RequestModel(pedModel)

    -- Attendre que le modèle soit bien chargé
    while not HasModelLoaded(pedModel) do
        Wait(500) -- Attente de 500 ms avant de vérifier à nouveau
    end

    -- Créer le ped à la position spécifiée
    local ped = CreatePed(4, pedModel, pos.x, pos.y, pos.z, 0.0, true, false)

    -- S'assurer que le ped soit bien orienté et immobile
    SetEntityHeading(ped, 8.8) -- Orientation du ped (regardant vers le nord)
    SetEntityInvincible(ped, true)  -- Rendre le ped invincible
    SetEntityVisible(ped, true)     -- Rendre le ped visible
    SetBlockingOfNonTemporaryEvents(ped, true) -- Empêche le ped de bouger ou d'agir de manière aléatoire

    -- Donner au ped un comportement de type "illégal" (rester immobile par exemple)
    TaskStandStill(ped, -1) -- Reste immobile pendant un temps illimité

    -- Ajouter une animation pour rendre le ped encore plus réaliste (par exemple, prendre une pose menaçante)
    -- Vous pouvez changer cette animation en fonction de l'effet que vous voulez
    TaskStartScenarioInPlace(ped, "WORLD_HUMAN_STAND_MOBILE", 0, true)
end)
