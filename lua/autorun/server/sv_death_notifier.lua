if engine.ActiveGamemode() ~= "terrortown" and gmod.GetGamemode().Name ~= "Trouble in Terrorist Town" then return end
if SERVER then
    util.AddNetworkString("ClientDeathNotify")
    local function GetDeathInfo(victim, entity, killer)
        local reason, killerz, role = "nil", "nil", "nil"
        if IsValid(killer) then
            if killer:IsPlayer() then
                if killer == victim then
                    reason = "suicide"
                else
                    reason = "ply"
                    killerz = killer:Nick()
                    role = killer:GetRole()
                end
            end
        end

        if IsValid(entity) then
            if entity:GetClass() == "entityflame" then
                reason = "burned"
                entity:Remove()
            elseif entity:GetClass() == 'prop_physics' or entity:GetClass() == "prop_dynamic" then
                reason = "prop"
            elseif entity:GetClass() == "worldspawn" then
                reason = "fell"
            end
        end

        if victim.DiedByWater then reason = "water" end
        if reason == "nil" and victim:IsPlayer() and victim:HasWeapon("weapon_ttt_jihad") then
            reason = "suicide"
            killerz = victim:Nick()
            role = victim:GetRole()
        end
        return killerz, role, reason
    end

    hook.Add("EntityTakeDamage", "Record_Last_Attacker", function(target, dmginfo) if IsValid(target) and target:IsPlayer() and IsValid(dmginfo:GetAttacker()) then target.LastAttacker = dmginfo:GetAttacker() end end)
    hook.Add("PlayerDeath", "Kill_Reveal_Notify", function(victim, entity, killer)
        if not IsValid(killer) and IsValid(victim.LastAttacker) then killer = victim.LastAttacker end
        local killerz, role, reason = GetDeathInfo(victim, entity, killer)
        net.Start("ClientDeathNotify")
        net.WriteString(killerz or "Unknown")
        net.WriteString(tostring(role or "0"))
        net.WriteString(reason or "unknown")
        net.Send(victim)
    end)
end
