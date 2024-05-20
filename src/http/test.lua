local send = require("WebhookDiscord");
local embedutil = require("CreateEmbed");
print(send(
    "",
    nil, nil, nil, { embedutil.Embed(
        "TASK LEVEL: 14",
        "過労！！<:red_decal:1204920076042641468>", nil, nil,
        0xff0000, nil,
        embedutil.URL("https://cdn.discordapp.com/attachments/1193112697886224384/1226433963082387557/warning.jpeg"), nil,
        nil,
        embedutil.Author("実行者: まめーん.lua")
    ) }
))
