local musics = {}
while true do
    term.clear()
    term.setCursorPos(1, 1)
    print("You can get .dfpwm file on \nhttps://music.madefor.cc/")
    print("You have " .. #musics .. " music(s)")
    print("If you type 'end', then play music. URLs:")
    local musicurl = read()
    if not musicurl == "end" then
        musics[#musics + 1] = musicurl
    else
        break
    end
end
local i = 0

while true do
    for index, value in next, musics do
        print(index .. ": " .. value + 1)
        term.clear()
        print("I am playing " .. i .. " time(s).")
        shell.execute("speaker", "play", value)
    end
    i = i + 1
end
