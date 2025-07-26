local Players = game:GetService("Players")
local lp = Players.LocalPlayer

-- ⚠️ Проверка Kick (перехваченный через __namecall или прямой подменой)
local function testKick()
    local success, result = pcall(function()
        local mt = getrawmetatable(game)
        if not mt then return false end

        local test = setmetatable({}, { __namecall = function() return "ok" end })
        return test:Kick() == "ok"
    end)

    if success and result == "ok" then
        return true -- перехват Kick
    else
        return false -- всё чисто
    end
end

-- ⚠️ Проверка подмены debug.getinfo
local function testDebug()
    local ok, info = pcall(function()
        return debug.getinfo(warn)
    end)
    return not (ok and info and info.source == "=[C]")
end

-- 🧠 Реакция на нарушения
if testKick() then
    warn("🚫 Кик был перехвачен кряком")
    lp:Kick("Обнаружен обход кика")
elseif testDebug() then
    warn("🚫 debug.getinfo подменён")
    lp:Kick("Подмена debug.getinfo")
end
