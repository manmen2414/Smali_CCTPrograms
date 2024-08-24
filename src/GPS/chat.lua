return function(at, name, text)
    peripheral.find("chatBox").sendMessageToPlayer(text, at, name)
end
