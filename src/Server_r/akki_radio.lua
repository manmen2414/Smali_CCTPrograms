local akki1 = 0
local songs = {"Song 1"}
local songtype = 0
local akki1 = 0
while true do
    local monitor = peripheral.find("monitor") --need moniter
    songtype = songtype + 1
    akki1 = akki1 + 1
for index, value in next, array do
	if(songtype == index+1) then
  songname = value
  break
 end
end
    local akki = string.format("%d.dfpwm", akki1)
    monitor.setBackgroundColor(colors.white)
    monitor.clear()
    monitor.setTextColor(colors.black)
    monitor.setCursorPos(1, 1)
    monitor.write("Now Playing: ")
    monitor.write(songname)
    shell.run("speaker play", akki) --need speaker
    if ( akki1 == #songs ) then
    akki1 = 0
    end
    if ( songtype == #songs ) then
    songtype = 0
    end 
end

--Files

--1.dfpwm
--2.dfpwm
-- ...