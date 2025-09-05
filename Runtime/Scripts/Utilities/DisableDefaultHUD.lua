--Disables the vanilla Ravenfield HUD
behaviour("DisableDefaultHUD")

function DisableDefaultHUD:Start()
	self:DisableDefaultHUD()
end

function DisableDefaultHUD:DisableDefaultHUD()
	PlayerHud.HideUIElement(UIElement.PlayerHealth)
	PlayerHud.HideUIElement(UIElement.VehicleInfo)
	PlayerHud.HideUIElement(UIElement.VehicleRepairInfo)
	PlayerHud.HideUIElement(UIElement.SquadOrderLabel)
	PlayerHud.HideUIElement(UIElement.SquadMemberInfo)
	PlayerHud.HideUIElement(UIElement.WeaponInfo)
	PlayerHud.HideUIElement(UIElement.OverlayText)
end
