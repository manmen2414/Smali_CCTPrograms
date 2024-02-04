local musics = {}
while true do
    term.clear()
    term.setCursorPos(1, 1)
    print("You can get .dfpwm file on \nhttps://music.madefor.cc/")
    print("You have " .. #musics .. " music(s)")
    print("Type 'end':Play")
    print("Type 'save':Save Playlist")
    print("Type 'load':Load Playlist")
    print("Please URL or command:")
    local musicurl = read()
    if musicurl == "end" then
        --print(4)
        break
    elseif musicurl == "save" then
        local text = ""
        print("Please type name")
        local path = read()
        for index, value in next, musics do
            text = text .. "\n" .. value
            print("Writing music" .. index)
        end
        local file = fs.open(path, "w")
        file.write(text)
        file.close()
        print("-End!")
    elseif musicurl == "load" then
        term.clear()
        term.setCursorPos(1, 1)
        print("Please type .mplaylist path")
        local path = read()
        local file = fs.open(path .. ".mplaylist", "r")
        local linenum = 0
        while true do
            local line = file.readLine()
            if not line then break end
            if not linenum == 0 then
                musics[#musics + 1] = line
                print("Adding music...")
            end
            linenum = linenum + 1
        end
        file.close()
        print("-End!")
    else
        musics[#musics + 1] = musicurl
        print("Adding music...")
    end
    --print(3)
    sleep(0.5)
end
local i = 0

while true do
    for index, value in next, musics do
        --print(4)
        term.clear()
        term.setCursorPos(1, 1)
        print("I am playing " .. i .. " time(s).\nhold CTRL+R:end\nhold CTRL+T:next")
        shell.execute("speaker", "play", value)
        --print(5)
    end
    --print(6)
    sleep(0.5)
    i = i + 1
    --print(7)
end
