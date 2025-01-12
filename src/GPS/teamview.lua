return function(name)
    local teams = {
        ---example MCID = "teamName"
        AM_107ryu = "",
    }
    local teamColors = {
        ---example ["Team"] = color
        ---NoTeam is used when player has no team.
        ["NoTeam"] = colors.white
    }
    local team = teams[name] or "NoTeam"
    return teamColors[team], team;
end
