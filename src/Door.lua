pass = ("password")
print("Enter password.")
a = read()
if a == pass then
    print("Password correct!")
    rs.setOutput("front", true)
    sleep(1)
    rs.setOutput("front", false)
else
    print("Password incorrect!")
end
os.run({}, "rom/programs/clear")
