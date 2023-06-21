                                                      
-- `8.`888b                 ,8'           `8.`8888.      ,8' 
-- `8.`888b               ,8'             `8.`8888.    ,8'  
--  `8.`888b             ,8'               `8.`8888.  ,8'   
--   `8.`888b     .b    ,8'                 `8.`8888.,8'    
--    `8.`888b    88b  ,8'                   `8.`88888'     
--     `8.`888b .`888b,8'                    .88.`8888.     
--      `8.`888b8.`8888'                    .8'`8.`8888.    
--       `8.`888`8.`88'                    .8'  `8.`8888.   
--        `8.`8' `8,`'                    .8'    `8.`8888.  
--         `8.`   `8'                    .8'      `8.`8888. 

wx = {}

wx.useTarget = true -- Use ox_target instead of item?
wx.removeHeadbagOnRespawn = true -- If player get his headbag removed when he (re)spawns?

wx.Locale = { -- You can translate the script here
    HeadbagTarget = "Use Headbag",
    ContextTitle = "Headbag Menu",
    ContextPutOn = "Put on headbag",
    ContextDescPutOn = "Use your headbag to put it on another player",
    ContextTakeOff = "Take off headbag",
    ContextDescTakeOff = "Take off headbag from the closest player",
    NotifyTitle = "Headbag",
    NotifyPutOn = "You put a headbag on a player",
    NotifyTookOff = "Someone took off your headbag",
    NotifyAlreadyOn = "This player already has a headbag!",
    NotifyNoOneNearby = "No one is nearby",
    NotifyNoHeadbag = "You don't have any headbags",
    Unpacking = "Unpacking headbag...",
}

function Notification(title,desc) -- You can edit your notify function here
    lib.notify({
        title = title,
        description = desc,
        position = 'top',
        style = {
            backgroundColor = '#1E1E2E',
        },
        icon = 'masks-theater',
    })
end

-- wx.removeHeadbags = true -- Couldn't get it to work. Leaving it here so someone can make a PR?

-- This was meant to work like this: You put a headbag on another player, the item get's removed from your inventory.
-- You took off the headbag, the item gets returned to you. Problem was I couldn't find a good method to check if player already
-- put the headbag on another player, so when you selected "take off" even if the player didn't had the headbag on, you still got the item...
-- Badly explained I know but maybe someone understands...
