local Players = game:GetService("Players")
local lp = Players.LocalPlayer

local suspiciousAPIs = {
    "getgenv", "getgc", "getreg", "hookfunction", "checkcaller", "getconnections"
}

-- 1. Проверка Kick
local success, info = pcall(function()
    return debug.getinfo(lp.Kick)
end)

if not success or (info and info.source ~= "=[C]") then
    warn("🚫 Kick был подменён")
    lp:Kick("Обнаружена подмена Kick")
end

-- 2. Проверка debug.getinfo самого себя
local originalDebugInfo = rawget(debug, "getinfo")
if not originalDebugInfo or tostring(originalDebugInfo):find("function: 0x") == false then
    warn("🚫 debug.getinfo подменён")
    lp:Kick("debug.getinfo был захучен")
end

-- 3. Проверка перехвата namecall
local testObj = setmetatable({}, {
    __namecall = function(self, ...)
        return "test"
    end
})

local worked = false
pcall(function()
    worked = testObj:Kick()
end)

if not worked then
    warn("🚫 Обнаружен хук на __namecall (обход Kick)")
    lp:Kick("Обнаружена защита от кика через namecall")
end

-- 4. Проверка опасных API
for _, api in ipairs(suspiciousAPIs) do
    local fn = rawget(_G, api) or rawget(getfenv(), api)
    if typeof(fn) == "function" then
        warn("🚨 Найден подозрительный модуль: " .. api)
        lp:Kick("Запрещённая функция: " .. api)
    end
end
