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
        print(1)
    else
        print(2)
        break
    end
    print(3)
    sleep(0.5)
end
local i = 0

while true do
    for index, value in next, musics do
        print(4)
        print(index .. ": " .. value + 1)
        term.clear()
        print("I am playing " .. i .. " time(s).")
        shell.execute("speaker", "play", value)
        print(5)
    end
    print(6)
    sleep(0.5)
    i = i + 1
    print(7)
end
