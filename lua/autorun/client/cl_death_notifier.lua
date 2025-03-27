if CLIENT then
    net.Receive("ClientDeathNotify", function()
        local reason = net.ReadString()
        local killerName = net.ReadString()
        local killerRole = net.ReadInt(8)
        local TraitorColor = Color(255, 0, 0)
        local InnoColor = Color(0, 255, 0)
        local DetectiveColor = Color(0, 0, 255)
        local NameColor = Color(142, 68, 173)
        local White = Color(236, 240, 241)
        local roleText = LANG.GetTranslation("killer_unknowns")
        local col = White
        if killerRole == ROLE_INNOCENT then
            col = InnoColor
            roleText = LANG.GetTranslation("killer_ply_innocent")
        elseif killerRole == ROLE_TRAITOR then
            col = TraitorColor
            roleText = LANG.GetTranslation("killer_ply_traitor")
        elseif killerRole == ROLE_DETECTIVE then
            col = DetectiveColor
            roleText = LANG.GetTranslation("killer_ply_detective")
        end

        local deathMessages = {
            suicide = LANG.GetTranslation("killer_suicide"),
            burned = LANG.GetTranslation("killer_burned"),
            prop = LANG.GetTranslation("killer_prop"),
            fell = LANG.GetTranslation("killer_fell"),
            water = LANG.GetTranslation("killer_water"),
            unknown = LANG.GetTranslation("killer_unknown")
        }

        if reason == "ply" then
            chat.AddText(NameColor, LANG.GetTranslation("killer_you"), White, LANG.GetTranslation("killer_yous"), col, killerName, White, LANG.GetTranslation("killer_comma"), col, roleText, LANG.GetTranslation("killer_exclamation"))
        else
            chat.AddText(NameColor, deathMessages[reason] or deathMessages["unknown"])
        end
    end)
end
