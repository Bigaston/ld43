local appId = require("lib/gameID")

-- Use discordRPC.lua by Joel Schumacher (see lib/LICENCE.md for more information)

function init_discord()
    discordRPC.initialize(appId, true)
    now = os.time(os.date("*t"))
    presence = {
        details = "Play in level "..current_level,
        startTimestamp = now,
        largeImageKey = "logo"
    }

    nextPresenceUpdate = 0
end

function update_discord()
    if nextPresenceUpdate < love.timer.getTime() then
        presence = {
            details = "Play in level "..current_level,
            startTimestamp = now,
            largeImageKey = "logo"
        }
        discordRPC.updatePresence(presence)
        nextPresenceUpdate = love.timer.getTime() + 2.0
    end
    discordRPC.runCallbacks()
end

function draw_discord()

end