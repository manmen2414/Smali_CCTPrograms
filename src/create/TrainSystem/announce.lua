--VOICEVOX:四国めたん
--VOICEVOX:Shicoku Metann

print("What train type?")
local train_type = read()
print("What bound?")
local bound = read()
print("What track number?")
local track_number = read()

local base = "speaker play https://github.com/manmen2414/study_lua_manmen2414/raw/main/Announce/"
--main
--memo: まもなく。<int>番線に<string><string>行きが参ります。危ないですから黄色い線の内側でお待ちください。


--まもなく
shell.run(base .. "string_mamonaku.dfpwm")

--(番線)

if track_number == "1" then
    shell.run(base .. "number_1.dfpwm")
end
--番線に
shell.run(base .. "string_bansenni.dfpwm")

--種別
if train_type == "Local" then
    shell.run(base .. "Train_Type_Local.dfpwm")
end

--メイン部分
shell.run(base .. "string_main.dfpwm")
