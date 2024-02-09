local printer = peripheral.find("printer")

-- Start a new page, or print an error.
if not printer.newPage() then
    error("Cannot start a new page. Do you have ink and paper?")
end

-- Write to the page
printer.setPageTitle("Hello")
printer.write("This is my first page")
printer.setCursorPos(1, 3)
printer.write("This is two lines below.")

-- And finally print the page!
if not printer.endPage() then
    error("Cannot end the page. Is there enough space?")
end
