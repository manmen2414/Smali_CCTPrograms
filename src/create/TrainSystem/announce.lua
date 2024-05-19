print("What train type?")
local train_type=read()
print("What bound?")
local bound=read()
print("What track number?")
local track_number=read()

--main
--memo: まもなく。<int>番線に<string><string>行きが参ります。危ないですから黄色い線の内側でお待ちください。


--まもなく
shell.run("speaker play https://cdn.discordapp.com/attachments/1241704009790918748/1241733189635014756/string_mamonaku.dfpwm?ex=664b45a6&is=6649f426&hm=5061bcc1c5ec6e9fa5eae34fedfa3e1cf5c2dbccd2a0ead93183fdf52c6e9dca&")

--(番線)

if track_number == "1" then
    shell.run("speaker","play","https://cdn.discordapp.com/attachments/1241704009790918748/1241704028287533106/number_1.dfpwm?ex=664b2a7e&is=6649d8fe&hm=a2d9151ba7b02b4eaab81c77472aedd847659afb7d9542f05381abe5b32efcf8&")
end
--番線に
shell.run("speaker play https://cdn.discordapp.com/attachments/1241704009790918748/1241733809423122514/string_bansenni.dfpwm?ex=664b463a&is=6649f4ba&hm=1c4d1461a8d4d97209089201f33826e7ed52fdbb39a329282678e0d621579f40&")

--種別
if train_type == "Local" then
    shell.run("speaker","play","https://cdn.discordapp.com/attachments/1241704009790918748/1241730918666735736/Train_Type_Local.dfpwm?ex=664b4389&is=6649f209&hm=475a33dd9d9da1cb1f0edafc29ea0d6d3a277bc8f561ed135daa7253c59e30bb&")
end

--メイン部分
shell.run("speaker play https://cdn.discordapp.com/attachments/1241704009790918748/1241735511354376242/string_main.dfpwm?ex=664b47d0&is=6649f650&hm=94478e9c40fa457515fda5edf022407e2a5431814e246ad67bbb81735600ebb1&")