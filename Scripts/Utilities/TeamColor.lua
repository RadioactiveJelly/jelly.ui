--Sets the target graphic's color to the player team's Default interface color
behaviour("TeamColor")

function TeamColor:Start()
	local playerTeam = Player.team

	self.targets.Graphic.color = ColorScheme.GetInterfaceColor(playerTeam, ColorVariant.Default)
end
