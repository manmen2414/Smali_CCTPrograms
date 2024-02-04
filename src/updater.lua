term.clear()
term.setCursorPos(1, 1)
print(">>> Study lua manmen2414 updater <<<")
print("What do you want to update?")
print("+ play_music_inf\n+ updater")
local value = read()
if value == "play_music_inf" then
    shell.execute("delete", "play_music_inf.lua")
    print("[Get] play_music_inf.lua")
    shell.execute("wget", "https://raw.githubusercontent.com/manmen2414/study_lua_manmen2414/main/src/play_music_inf.lua")
    print("----- END -----")
elseif value == "updater" then
    shell.execute("delete", "updater.lua")
    print("[Get] updater.lua")
    shell.execute("wget", "https://raw.githubusercontent.com/manmen2414/study_lua_manmen2414/main/src/updater.lua")
    print("----- END -----")
else
    print("Your select is wrong.")
end
