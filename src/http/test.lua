local send = require("WebhookDiscord");
local embedutil = require("CreateEmbed");
print(send(
    "https://discord.com/api/webhooks/1137377531322970205/LlMskpsrv8CDMZtFHNkyqfjPSjpku0i19QGQB7r9BFHOVpJIAsICQ7yWd4i3v6it1BCJ",
    nil, nil, nil, { embedutil.Embed(
        "TASK LEVEL: 14",
        "過労！！<:red_decal:1204920076042641468>", nil, nil,
        0xff0000, nil,
        embedutil.URL("https://cdn.discordapp.com/attachments/1193112697886224384/1226433963082387557/warning.jpeg"), nil,
        nil,
        embedutil.Author("実行者: まめーん.lua")
    ) }
))
