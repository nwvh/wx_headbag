local hasBag = false -- Check if player has headbag on
local bags = {}

function GetClosestPlayer() -- Find the closest player and trigger event to get headbag on his head
  local closestPlayer = lib.getClosestPlayer(GetEntityCoords(PlayerPedId()), 2.0, false)
  if closestPlayer == nil or not closestPlayer then -- If the closest player in 2.0 units isn't found
    Notification(wx.Locale.NotifyTitle,wx.Locale.NotifyNoOneNearby)
  else -- If he IS found
    if not hasBag then -- Check if player doesn't already have headbag
      TriggerServerEvent('wx_headbag:closestPlayer', GetPlayerServerId(closestPlayer))
      Notification(wx.Locale.NotifyTitle,wx.Locale.NotifyPutOn)
      TriggerServerEvent('wx_headbag:closest')
      hasBag = true
    else
      hasBag = false
      Notification(wx.Locale.NotifyTitle,wx.Locale.NotifyAlreadyOn)
    end
  end
end


RegisterNetEvent('wx_headbag:putOn') -- Simple trigger to put on the headbag
AddEventHandler('wx_headbag:putOn', function()
    Headbag = CreateObject(GetHashKey("prop_money_bag_01"), 0, 0, 0, true, true, true)
    AttachEntityToEntity(Headbag, GetPlayerPed(-1), GetPedBoneIndex(GetPlayerPed(-1), 12844), 0.22, 0.04, 0, 0, 270.0, 60.0, true, true, false, true, 1, true)
    table.insert(bags,Headbag)
    SendNUIMessage({type = 'bagOn'}) -- Trigger NUI image of the headbag (make player blind)
    SetNuiFocus(false,false) -- idk why but without this the player is stuck in the nui
    hasBag = true
end)

RegisterNetEvent('wx_headbag:takeOff') -- Simple trigger to take the bag off
AddEventHandler('wx_headbag:takeOff', function()
  Notification(wx.Locale.NotifyTitle,wx.Locale.NotifyTookOff)
  DeleteEntity(Headbag)
  SetEntityAsNoLongerNeeded(Headbag)
  SendNUIMessage({type = 'bagOff'})
  hasBag = false
end)

local function bagmenu() -- Function to open the bag menu
  lib.registerContext({
    id = 'headbag',
    title = wx.Locale.ContextTitle,
    options = {
      {
        title = wx.Locale.ContextPutOn,
        description = wx.Locale.ContextDescPutOn,
        icon = 'mask',
        onSelect = function()
          GetClosestPlayer()
        end,

      },
      {
        title = wx.Locale.ContextTakeOff,
        description = wx.Locale.ContextDescTakeOff,
        icon = 'masks-theater',
        onSelect = function()
          TriggerServerEvent('wx_headbag:takeOff')
        end,

      },

    }
  })

  lib.showContext('headbag')
end

RegisterNetEvent('wx_headbag:openMenu') -- Trigger to open the bag menu
AddEventHandler('wx_headbag:openMenu',function ()
  local count = exports.ox_inventory:Search('count', 'headbag') -- Check if player has headbag in his inventory
  if count >= 1 or hasBag then
      if lib.progressCircle({
        duration = math.random(4000,5000),
        position = 'bottom',
        useWhileDead = false,
        canCancel = true,
        label = wx.Locale.Unpacking,
        disable = {
            car = true,
            move = true,
            combat = true,
        },
        anim = {
            dict = 'mp_arresting',
            clip = 'a_uncuff'
        },
        prop = {
          model = `prop_money_bag_01`,
          pos = vec3(0.013, 0.03, 0.022),
          rot = vec3(0.0, 0.0, -1.5)
      },
    }) then
      bagmenu()
    
    end
    
    -- bagmenu()
  else
    Notification(wx.Locale.NotifyTitle,wx.Locale.NotifyNoHeadbag) -- If not, throw an error
  end
end)

if wx.useTarget then -- Enable ox_target functions
  local options = {
    {
        name = 'headbagMenu',
        event = 'wx_headbag:openMenu',
        distance = 2,
        icon = 'fa-solid fa-masks-theater',
        label = wx.Locale.HeadbagTarget,
    },
  }
  exports.ox_target:addGlobalPlayer(options)
end

if not wx.useTarget then -- If the target option is disabled, use export to use the item straight from the inventory
  exports('headbag', function()
    lib.progressCircle({
      duration = math.random(4000,5000),
      position = 'bottom',
      useWhileDead = false,
      canCancel = true,
      label = wx.Locale.Unpacking,
      disable = {
          car = true,
          move = true,
          combat = true,
      },
      anim = {
          dict = 'mp_arresting',
          clip = 'a_uncuff'
      },
      prop = {
        model = `prop_money_bag_01`,
        pos = vec3(0.013, 0.03, 0.022),
        rot = vec3(0.0, 0.0, -1.5)
    },
  })
    TriggerEvent('wx_headbag:openMenu')
  end)
end

AddEventHandler('onResourceStop',function (resourceName) -- Delete all bags if the resource stops
  if resourceName == GetCurrentResourceName() then
    for _, bag in pairs(bags) do
      DeleteEntity(bag)
    end
  end
end)

if wx.removeHeadbagOnRespawn then
  AddEventHandler('playerSpawned', function() -- If player (re)/spawns, remove the headbag
    DeleteEntity(Headbag)
    SetEntityAsNoLongerNeeded(Headbag)
    SendNUIMessage({type = 'bagOff'})
    hasBag = false
  end)
end

Citizen.CreateThread(function ()
  while true do
    Wait(0)
    for k,v in pairs(bags) do
      if not k or not v then
        print(bags)
        hasBag = false
      end
    end
  end
end)