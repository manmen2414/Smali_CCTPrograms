args = { ... }
local Program = {}
local Project = {}
local githubPath = "https://raw.githubusercontent.com/manmen2414/Smali_CCTPrograms/main/src/"
---@return Program
---@param FilePath string
---@param ProjectRoot string
---@param IsAddon boolean?
function Program.new(FilePath, ProjectRoot, IsAddon)
    ---@class Program
    local program = {};
    if not http then
        error("This server doesn't support http.")
    end
    program.filePath = FilePath;
    program.projectRoot = ProjectRoot;
    program.isAddon = IsAddon or false;
    program.fullPath = ProjectRoot .. "/" .. FilePath;
    program.installPath = githubPath .. program.fullPath;
    program.file = FilePath:match("[^/]+$")
    program.folders = {};
    local getFolder = FilePath:gmatch("[^/]+/")
    for folder in getFolder do
        program.folders[#program.folders + 1] = folder
    end
    function program.install(self, falsereturn)
        local fullDir = "";
        for _, value in ipairs(self.folders) do
            fullDir = fullDir .. value
            if not fs.exists("/" .. fullDir) then
                fs.makeDir("/" .. fullDir)
            end
        end
        local req;
        if falsereturn then
            req = "return false;"
        else
            req = http.get(self.installPath);
        end
        local content = req.readAll();
        req.close();
        local pipe = fs.open(self.filePath, "w")
        pipe.write(content);
        pipe.close();
    end

    return program;
end

---@return Project
---@param Root string
function Project.new(Root)
    ---@class Project
    local project = {};
    project.root = Root;
    ---@type Program[]
    project.files = {};
    function project.install(self, List)
        for index, value in ipairs(self.files) do
            print("Installing " .. value.file)
            value:install(not value.isAddon or List[index])
        end
    end

    ---@param FilePath string
    ---@param IsAddon boolean?
    function project.add(self, FilePath, IsAddon)
        IsAddon = IsAddon or false;
        self.files[#self.files + 1] = Program.new(FilePath, self.root, IsAddon);
        return self;
    end

    ---@param program Program
    function project.addProgram(self, program)
        self.files[#self.files + 1] = program;
        return self;
    end

    return project;
end

local Projects = {
    ModifyableMover = Project.new("ModifyableMover/"):add("setting.json"):add("startup.lua"):add("setting.lua")
        :addProgram(Program.new("gui.lua", "GUI/", false)),
    GPS = Project.new("GPS/"):add("chat.lua", true):add("GPS.lua"):add("health.lua"):add("item.lua", true)
        :add("ItemTeleporter.lua", true):add("position.lua"):add("startup.lua"):add("teamview.lua", true):add(
            "webhook.lua", true)
}
local ProjectKeys = {}
for key, value in pairs(Projects) do
    ProjectKeys[#ProjectKeys + 1] = key;
end
local function Install(_project)
    local project = Projects[_project];
    if not project then
        print("404 Not found: " .. _project); return false;
    end
    term.write("Install " .. _project .. "?(Y/n): ")
    local ans = read();
    local InstallList = {};
    if ans == "n" or ans == "N" or ans == "no" or ans == "No" or ans == "NO" then return false; end
    for index, value in ipairs(project.files) do
        if value.isAddon then
            term.write("Install Addon " .. value.file .. "?(y/N): ")
            ans = read();
            if ans == "y" or ans == "Y" or ans == "Y" or ans == "Yes" or ans == "YES" then
                InstallList[#InstallList + 1] = true
            else
                InstallList[#InstallList + 1] = false
            end
        else
            InstallList[#InstallList + 1] = true;
        end
    end
    project:install(InstallList)
    print("Installed!")
    return true;
end
local function Uninstall(_project)
    local project = Projects[_project];
    if not project then
        print("404 Not found: " .. _project); return false;
    end
    term.write("Uninstall " .. _project .. "?(Y/n): ")
    local ans = read();
    if ans == "n" or ans == "N" or ans == "no" or ans == "No" or ans == "NO" then return false; end
    for index, value in ipairs(project.files) do
        if fs.exists(value.filePath) then
            print("Deleteing " .. value.file)
            fs.delete(value.filePath);
        end
    end
    print("Uninstalled!")
end
local function ReadProject()
    repeat
        term.write("Project: ");
        local ans = read(nil, nil, function(text)
            return require("cc.completion").choice(text, ProjectKeys)
        end)
        if Projects[ans] then
            return ans;
        end
    until false;
end
if not args[2] then
    repeat
        term.setTextColor(colors.yellow)
        term.write("Installer> ")
        term.setTextColor(colors.white);
        local ans = read(nil, nil, function(text)
            return require("cc.completion").choice(text, { "install", "uninstall", "exit" })
        end)
        if ans == "install" then
            local project = ReadProject();
            Install(project);
        elseif ans == "uninstall" then
            local project = ReadProject();
            Uninstall(project)
        elseif ans == "exit" then
            term.setTextColor(colors.yellow)
            print("Goodbye")
            sleep(1)
            return;
        end
    until false
end
if args[2] == "install" or args[2] == "i" then
    if not args[3] then
        local project = ReadProject();
        Install(project);
        return;
    elseif Projects[args[3]] then
        Install(args[3])
        return;
    end
    print("404 Not found: " .. args[3])
end

if args[2] == "uninstall" then
    if not args[3] then
        local project = ReadProject();
        Uninstall(project);
        return;
    elseif Projects[args[3]] then
        Uninstall(args[3])
        return;
    end
    print("404 Not found: " .. args[3])
end
