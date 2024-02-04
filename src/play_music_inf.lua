term.clear()
term.setCursorPos(1, 1)
print("URL:")
local url = read()
local i = 0

while true do
    i = i + 1
    term.clear()
    print("I am playing " + i + " time(s).")
    shell.execute("speaker", "play", url)
end
