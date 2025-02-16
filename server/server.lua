local VORPcore = exports.vorp_core:GetCore()


RegisterCommand(Config.ReportCommand, function(source, args, rawcommand)
    local src = source
    local Character = VORPcore.getUser(src).getUsedCharacter
    local Name = Character.firstname .. ' ' .. Character.lastname
    local CharID = Character.charIdentifier
    local ID = args[1]
    local Reason = args[2]
    if ID ~= nil then
        local ReportedUser = VORPcore.getUser(ID)
        if ReportedUser ~= nil then
            local ReportedCharacter = ReportedUser.getUsedCharacter
            local ReportedName = ReportedCharacter.firstname .. ' ' .. ReportedCharacter.lastname
            local ReportedCharID = ReportedCharacter.charIdentifier
            VORPcore.NotifyTip(src,_U('YouReportedPlayer') .. ReportedName,5000)
            if Config.ReportWebhook then
                VORPcore.AddWebhook(Config.WHTitle, Config.WHLink,_U('WHPlayer') .. Name .. _U('WHCharID') .. CharID .. _U('WHReportedPlayer') .. ReportedName .. _U('WHWithCharID') .. ReportedCharID .. _U('WHReportReason') .. Reason, Config.WHColor, Config.WHName, Config.WHLogo, Config.WHFooterLogo, Config.WHAvatar)
            end
            if Config.AlertAdmins then
                for h,v in ipairs(GetPlayers()) do
                    local Player = VORPcore.getUser(v).getUsedCharacter
                    local PlayerGroup = Player.group
                    if PlayerGroup == Config.AdminGroup then
                        VORPcore.NotifyCenter(v, _U('AlertAdminText') .. ReportedName .. _U('AlertAdminReason') .. Reason, Config.AlertAdminTime)
                    end
                end
            end
            if Config.AlertReportedPlayer then
                VORPcore.NotifyCenter(ID, _U('AlertPlayerText'), Config.AlertPlayerTime)
            end
        else
            VORPcore.NotifyTip(src,_U('IDNotFound'),5000)
        end
    else
        VORPcore.NotifyTip(src,_U('WrongInput'),5000)
    end
end, false)

