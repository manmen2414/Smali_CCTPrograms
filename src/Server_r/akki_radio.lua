local akki1 = 0
local song1 = "Song 1" --曲数によって変える 7曲ある場合「local song7 = "曲名"」を追加する song 1とかsong 2のところには曲名を入れる
local song2 = "Song 2"
local song3 = "Song 3"
local song4 = "Song 4"
local song5 = "Song 5"
local song6 = "Song 6"
local songtype = 0
local akki1 = 0
while true do
    local monitor = peripheral.find("monitor") --モニターが必要
    songtype = songtype + 1
    akki1 = akki1 + 1
    if ( songtype == 1 ) then --めんどいからifでごり押したやつ 曲数によってifの数を変更する
    songname = song1
    elseif ( songtype == 2 ) then
    songname = song2
    elseif ( songtype == 3 ) then
    songname = song3
    elseif ( songtype == 4 ) then
    songname = song4
    elseif ( songtype == 5 ) then
    songname = song5
    elseif ( songtype == 6 ) then
    songname = song6
    end
    local akki = string.format("%d.dfpwm", akki1)
    monitor.setBackgroundColor(colors.white)
    monitor.clear()
    monitor.setTextColor(colors.black)
    monitor.setCursorPos(1, 1)
    monitor.write("Now Playing: ")
    monitor.write(songname)
    shell.run("speaker play", akki) --スピーカーが必要
    if ( akki1 == 6 ) then --"6"は入っている曲数によって変える
    akki1 = 0
    end
    if ( songtype == 6 ) then --これも同じく入っている曲数によって変える
    songtype = 0
    end 
end