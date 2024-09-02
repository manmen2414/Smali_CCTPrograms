return function(name)
    local teams = {
        ---example MCID = "teamName"
        AM_107ryu = "japan",
    }
    local teamColors = {
        ---example ["Team"] = color
        ["japan"] = colors.yellow,
        ["NoTeam"] = colors.white
    }
    local team = teams[name] or "NoTeam"
    return teamColors[team], team;
end
