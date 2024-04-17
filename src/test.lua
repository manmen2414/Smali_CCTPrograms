--[[渡されたテーブルの中身をdebug_printする関数]]
local function load_G(m, mt, s)
    if (type(mt) ~= "table") then
        mt = { m }
    else
        mt[#mt + 1] = m
    end

    --これ、どうにかしたいね…
    --debug_print(string.format("%d",#mt))

    for k, v in pairs(m) do
        print(s .. k .. " = " .. tostring(v) .. "\n")
        if (type(m[k]) == "table") then
            local ch = 1
            for i = 1, #mt do
                if (mt[i] == m[k]) then
                    ch = 0
                    break
                end
            end

            if (ch == 1) then
                load_G(m[k], mt, s .. k .. ".")
            end
        end
    end
end

TEST = {}
local c = 0
for i = 1, 10 do
    TEST[i] = {}
    for j = 1, 10 do
        c = c + 1
        TEST[i][j] = c
    end
end

os.execute("cls") --[[コンソールクリア]]
load_G(_G, 0, "_G.") --[[_Gのテーブルをコンソールに書き出す]]
