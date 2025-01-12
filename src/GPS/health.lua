local playerDetector = peripheral.find("playerDetector") or error("playerDetector not found")
return function(name)
    return playerDetector.getPlayer(name).health
end
