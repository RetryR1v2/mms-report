local VORPcore = exports.vorp_core:GetCore()

-- Chat Suggestion for 
local commandDescription = '/' .. Config.ReportCommand .. ' ID (PlayerID) | Reason (Report Reason)'
TriggerEvent('chat:addSuggestion', '/' .. Config.ReportCommand, commandDescription)