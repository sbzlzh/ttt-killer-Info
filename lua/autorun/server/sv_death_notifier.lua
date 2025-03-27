if SERVER then
    AddCSLuaFile()
    util.AddNetworkString("ClientDeathNotify")
    local function GetDeathReason(victim, inflictor, attacker)
        if not IsValid(victim) then return "unknown" end
        if victim:WaterLevel() >= 3 then return "water" end
        if victim == game.GetWorld() or (not IsValid(attacker) and not IsValid(inflictor)) then return "fell" end
        if IsValid(inflictor) and inflictor:GetClass() == "env_fire" then return "burned" end
        if IsValid(attacker) and attacker:GetClass() == "prop_physics" then return "prop" end
        --if IsValid(inflictor) and inflictor:GetClass() == "weapon_ttt_jihad" then return "jihad" end
        if IsValid(attacker) and attacker:IsPlayer() then
            if attacker == victim then
                return "suicide"
            else
                return "ply", attacker:Nick(), attacker:GetRole()
            end
        end
        return "suicide"
    end

    hook.Add("PlayerDeath", "TTTDeathNotifier", function(victim, inflictor, attacker)
        local reason, killerName, killerRole = GetDeathReason(victim, inflictor, attacker)
        net.Start("ClientDeathNotify")
        net.WriteString(reason)
        net.WriteString(killerName or "")
        net.WriteInt(killerRole or -1, 8)
        net.Send(victim)
    end)
end
