local function play(file)
    local dfpwm = require "cc.audio.dfpwm"
    local speaker = peripheral.find("speaker")

    local decoder = dfpwm.make_decoder()
    for input in io.lines(file, 16 * 1024) do
        local decoded = decoder(input)
        while not speaker.playAudio(decoded) do
            os.pullEvent("speaker_audio_empty")
        end
    end
end

play("a.dfpwm")
