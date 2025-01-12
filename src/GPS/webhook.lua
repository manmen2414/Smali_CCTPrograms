local discordId = {
    ---example MCID = "ID"
    AM_107ryu = "778582802504351745"
}
---.env
---```env
---WEBHOOK_URL="https://discord.com/..."
---```
local webhook_url = nil;
if webhook_url == nil then
    local env = fs.open(".env", "r")
    local existNext = true;
    while existNext do
        local text = env.readLine();
        local inner = text:match("^WEBHOOK_URL=\"(.+)\"")
        if inner then
            webhook_url = inner
            break;
        end
        if not text then
            existNext = false;
            break;
        end
    end
end
local function Footer(text, icon_url)
    if text == nil then
        return nil;
    end
    local footertable = {};
    footertable["text"] = text;
    footertable["icon_url"] = icon_url;
    return footertable;
end

local function Field(name, value, inline)
    if name == nil or value == nil then
        return nil;
    end
    local fieldtable = {};
    fieldtable["name"] = name;
    fieldtable["value"] = value;
    fieldtable["inline"] = inline;
    return fieldtable;
end

local function Embed(title, description, color, footer, fields)
    local embedtable = {};
    embedtable["title"] = title;
    embedtable["type"] = "rich";
    embedtable["description"] = description;
    embedtable["color"] = color;
    embedtable["footer"] = footer;
    embedtable["fields"] = fields;
    return embedtable;
end
local function send(username, imageurl, embeds)
    local bodytable = {}
    bodytable["username"] = username;
    bodytable["avatar_url"] = imageurl;
    bodytable["embeds"] = embeds;
    local Resornil, reason = http.post(webhook_url, textutils.serialiseJSON(bodytable),
        { ["Content-Type"] = "application/json" });
    if Resornil == nil then
        return false, reason;
    else
        return true;
    end
end


return {
    ---@param players [string, number, number, number, string, number][]
    SendPosition = function(players, health)
        local fields = {}
        for index, player in ipairs(players) do
            fields[#fields + 1] = Field(player[1],
                string.format("%d,%d,%d | HP: %d |", player[2], player[3], player[4], (function()
                    if health then
                        return health(player[1])
                    else
                        return -1;
                    end
                end)()), false)
        end
        local embedobject = Embed("Player Position Report", nil, 0xfff301, Footer("AM_107ryu's GPS"), fields);
        textutils.serialiseJSON(embedobject)
        send(nil, nil, { embedobject })
    end,
    SendEmergency = function(description)
        send(nil, nil, { Embed("Emergency!!!", description, 0xff0000, Footer("AM_107ryu's GPS")) })
    end,
    onChat = function(username, content)
        send(username, "https://mc-heads.net/avatar/" .. username, { Embed(nil, content, 0xffffff) })
    end
}
