local speakers = { peripheral.find("speaker") };

local function newMusicFile(path)
    ---@class MusicFile
    local instance = {};
    local pipe = fs.open(path, "r");
    local data = pipe.readAll();
    pipe.close();
    local json = textutils.unserialiseJSON(data);
    ---@type number
    instance.bpm = json.bpm;
    ---@type number
    instance.start = json.start;
    ---@type {part:string,elements:[number,number|string,number][]}[]
    instance.items = json.items;
    ---@type {_:[number,number|string,number][]}
    instance.melodys = json.melodys

    function instance:play(speakers)
        local function sleepWithBpm(time)
            local kSound = 30 / self.bpm;
            local sleepTime = kSound * (time + 1);
            sleep(sleepTime);
        end
        ---@param part string
        ---@param pitch number 0~24
        ---@param long number?
        local function playNote(part, pitch, long)
            long = long or 0;
            --long=1, bpm=60の場合は一秒(20tick)
            local callCount = (60 * 20 * long) / self.bpm;
            for index, speaker in ipairs(speakers) do
                local function sound()
                    speaker.playNote(part, nil, pitch + self.start)
                end
                if (long == 0) then
                    sound()
                else
                    for i = 1, callCount, 1 do
                        sound()
                        if (i ~= callCount) then
                            sleep(0.05)
                        end
                    end
                end
            end
        end
        local function playElement(part, element)
            if (type(element[1]) == "string" or type(element[1]) == "table") then
                return;
            end
            sleepWithBpm(element[1]);
            if type(element[2]) == "string" then
                for index, atElement in ipairs(self.melodys[element[2]]) do
                    playElement(part, atElement)
                end
            else
                playNote(part, element[2], element[3]);
            end
        end
        ---@param item [number,number|string,number][]
        local function playPart(item)
            for index, element in ipairs(item.elements) do
                playElement(item.part, element)
            end
        end
        local playFuncs = {};
        for index, value in ipairs(self.items) do
            playFuncs[#playFuncs + 1] = function()
                playPart(value)
            end
        end
        parallel.waitForAll(table.unpack(playFuncs))
    end

    return instance
end

newMusicFile(arg[1]):play(speakers)
