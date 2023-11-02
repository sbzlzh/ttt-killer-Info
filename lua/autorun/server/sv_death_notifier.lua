if engine.ActiveGamemode() ~= "terrortown" and gmod.GetGamemode().Name ~= "Trouble in Terrorist Town" then
    return
end

if SERVER then
    util.AddNetworkString("ClientDeathNotify")

    local function GetDeathInfo(victim, entity, killer)
        local reason, killerz, role = "nil", "nil", "nil"

        if IsValid(entity) and IsValid(killer) then
            if entity:GetClass() == "entityflame" and killer:GetClass() == "entityflame" then
                reason = "burned"
                entity:Remove()
            elseif entity:GetClass() == 'prop_physics' or entity:GetClass() == "prop_dynamic" then
                reason = "prop"
            elseif killer:IsPlayer() then
                if killer == victim then
                    reason = "suicide"
                else
                    reason = "ply"
                    killerz = killer:Nick()
                    role = killer:GetRole()
                end
            end
        elseif victim.DiedByWater then
            reason = "water"
        elseif entity:GetClass() == "worldspawn" and killer:GetClass() == "worldspawn" then
            reason = "fell"
        end

        return killerz, role, reason
    end

    hook.Add("PlayerDeath", "Kill_Reveal_Notify", function(victim, entity, killer)
        local killerz, role, reason = GetDeathInfo(victim, entity, killer)

        net.Start("ClientDeathNotify")
        net.WriteString(killerz)
        net.WriteString(role)
        net.WriteString(reason)
        net.Send(victim)
    end)
end
