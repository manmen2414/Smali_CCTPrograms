return function(name)
    local teams = {
        AM_107ryu = "japan",
        H0nen0suke = "amarica",
        hosigaki09 = "amarica",
        Motchii709 = "japan",
        medakoro0321 = "amarica",
        harumaki_8787 = "amarica",
        Tamu1256tt = "amarica",
        akki__ = "ussr",
        Kaeru_No = "ussr",
        Meatwo310 = "ussr",
        AutumnMouse578 = "japan",
        kakitane2929 = "ussr",
        pupu_desu = "ussr",
    }
    local teamColors = {
        ["japan"] = colors.yellow,
        ["amarica"] = colors.blue,
        ["ussr"] = colors.red,
        ["NoTeam"] = colors.white
    }
    local team = teams[name] or "NoTeam"
    return teamColors[team], team;
end
