local suspicious = {
    "getgenv", "getgc", "getreg", "hookfunction", "checkcaller", "getconnections"
}
local function CheckForCrackModules()
    local Players = game:GetService("Players")
    local player = Players.LocalPlayer or nil

    local function kick(reason)
        if player and player.Kick then
            player:Kick("Reason: " .. reason)
        else
            error("Client was been deleted by developer.")
        end
    end
    for _, name in ipairs(suspicious) do
        if getfenv()[name] ~= nil then
            kick("Too much errors.")
        end
    end
    local info = debug.getinfo(warn)
    if info and info ~= "=[C]" then
        game.Players.LocalPlayer:Kick("Detected kick blocker.")
    end
    local success, info = pcall(function()
        return debug.getinfo(game.Players.LocalPlayer.Kick)
    end)

    if success and info and info.source ~= "=[C]" then
        warn("⚠️ Kick подменён")
        -- Лог, кик или отправка в Discord
    end
    if islclosure and islclosure(game.Players.LocalPlayer.Kick) then
        warn("Kick подменён Lua-функцией")
    end

end

CheckForCrackModules()
