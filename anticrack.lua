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
    local originalKick = game.Players.LocalPlayer.Kick
    local info1 = debug.getinfo(originalKick)

    if info1 and info1.source ~= "=[C]" then
        game.Players.LocalPlayer:Kick("Kick подменён")
    end
end

CheckForCrackModules()
