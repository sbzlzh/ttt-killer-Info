if engine.ActiveGamemode() ~= "terrortown" and gmod.GetGamemode().Name ~= "Trouble in Terrorist Town" then return end
if CLIENT then
    net.Receive("ClientDeathNotify", function()
        local TraitorColor = Color(255, 0, 0)
        local InnoColor = Color(0, 255, 0)
        local DetectiveColor = Color(0, 0, 255)
        local NameColor = Color(142, 68, 173)
        local UnknownColor = Color(152, 48, 196)
        local White = Color(236, 240, 241)
        local name = net.ReadString()
        local role = tonumber(net.ReadString())
        local reason = net.ReadString()
        if role == ROLE_INNOCENT then
            col = InnoColor
            role = LANG.GetTranslation("killer_ply_innocent")
        elseif role == ROLE_TRAITOR then
            col = TraitorColor
            role = LANG.GetTranslation("killer_ply_traitor")
        elseif role == ROLE_DETECTIVE then
            col = DetectiveColor
            role = LANG.GetTranslation("killer_ply_detective")
        else
            col = InnoColor
            role = LANG.GetTranslation("killer_unknowns")
        end

        if reason == "suicide" then
            chat.AddText(NameColor, LANG.GetTranslation("killer_suicide"))
        elseif reason == "burned" then
            chat.AddText(NameColor, LANG.GetTranslation("killer_burned"))
        elseif reason == "prop" then
            chat.AddText(NameColor, LANG.GetTranslation("killer_prop"))
        elseif reason == "ply" then
            chat.AddText(NameColor, LANG.GetTranslation("killer_you"), White, LANG.GetTranslation("killer_yous"), col, name, White, LANG.GetTranslation("killer_comma"), col, role, LANG.GetTranslation("killer_exclamation"))
        elseif reason == "fell" then
            chat.AddText(NameColor, LANG.GetTranslation("killer_fell"))
        elseif reason == "water" then
            chat.AddText(NameColor, LANG.GetTranslation("killer_water"))
        else
            chat.AddText(White, LANG.GetTranslation("killer_unknown"))
        end
    end)
end
