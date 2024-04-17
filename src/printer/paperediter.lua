local printer = peripheral.find("printer")

-- Start a new page, or print an error.
if not printer.newPage() then
    error("Cannot start a new page. Do you have ink and paper?")
end
term.clear();
term.setCursorPos(1, 1)
local cur = 1
local first = true;
while true do
    -- Write to the page
    if first then
        print("Paper name:")
        local input = read()
        printer.setPageTitle(input)
        first = false
        print("--------------- END:[!end!]")
    else
        local input = read()
        if input == "!end!" then
            -- And finally print the page!
            if not printer.endPage() then
                error("Cannot end the page. Is there enough space?")
            end
            break;
        else
            printer.setCursorPos(1, cur)
            printer.write(input)
            cur = cur + 1
        end
    end
end
