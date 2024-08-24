---Player Detectorの取得
local playerDetector = peripheral.find("playerDetector")
---画面サイズを取得(関係なし)
local x, y = term.getSize();
---charをcount回繰り返して出力(関係なし)
---@param char string
---@param count number
---@return string
local function repl(char, count)
    local ret = "";
    for i = 1, count, 1 do
        ret = ret .. char
    end
    return ret;
end
---textとcount文字の半角スペースを出力(関係なし)
---@param text string
---@param count number
---@return string
local function chargeText(text, count)
    return text .. repl(" ", count - #text)
end
local LineWhite = repl(" ", x)
term.clear();
repeat ---無限ループ
    term.setCursorPos(1, 1);
    local players = playerDetector.getOnlinePlayers();
    local usedLines = 0;
    for index, name in ipairs(players) do
        local player = playerDetector.getPlayer(name); ---プレイヤーの座標を取得する
        ---コンソールに[名前 > x,y,z HP:体力]の順に表示する 名前は20文字になる様に埋める
        print(string.format("%s > %d,%d,%d HP:%d", chargeText(name, 20), player.x, player.y, player.z, player.health));
        usedLines = usedLines + 1;
    end
    for i = 1, y - usedLines - 1, 1 do
        print(LineWhite);
    end
    sleep(0.25)
until false
