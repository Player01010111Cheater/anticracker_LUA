local suspicious = {
    "getgenv", "getgc", "getreg", "hookfunction", "checkcaller", "getconnections"
}
local normal = game.Players.LocalPlayer.Kick
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
    local info = debug.getinfo(normal)
    if info and info ~= "=[C]" then
        game.Players.LocalPlayer:Kick("Detected kick blocker.")
    end
end

CheckForCrackModules()
