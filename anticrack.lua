local suspicious = {
    "getgenv", "getgc", "getreg", "hookfunction", "checkcaller", "getconnections"
}
local function CheckForCrackModules()
    local Players = game:GetService("Players")
    local player = Players.LocalPlayer or nil
    
    local info1 = debug.getinfo(game.Players.LocalPlayer.Kick)
    if info1 and info1.source ~= "=[C]" then
        warn("⚠️ Kick подменён")
        -- Лог, кик или отправка в Discord
    end
end

CheckForCrackModules()
