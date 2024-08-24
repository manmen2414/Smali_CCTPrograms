local playerDetector = peripheral.find("playerDetector")
return function(name)
    return playerDetector.getPlayer(name).health
end
