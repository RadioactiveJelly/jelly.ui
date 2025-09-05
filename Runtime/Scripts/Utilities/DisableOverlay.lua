-- Register the behaviour
behaviour("DisableOverlay")

function DisableOverlay:Start()
	PlayerHud.HideUIElement(UIElement.OverlayText)
end