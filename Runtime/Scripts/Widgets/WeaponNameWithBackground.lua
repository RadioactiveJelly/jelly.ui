--Uses TextWithBackground script to display the player's current weapon name.
--Use the Prefix value on the DataContainer to adjust spacing.
behaviour("WeaponNameWithBackground")

function WeaponNameWithBackground:Start()
	self.script.AddValueMonitor("MonitorActiveWeapon", "OnActiveWeaponChanged")
	self.prefix = self.targets.DataContainer.GetString("Prefix")
end

function WeaponNameWithBackground:MonitorActiveWeapon()
	if Player.actor == nil then return nil end
	if Player.actor.activeWeapon == nil then return nil end

	return Player.actor.activeWeapon.activeSubWeapon
end

function WeaponNameWithBackground:OnActiveWeaponChanged(activeWeapon)
	if activeWeapon == nil then
		self.targets.TextWithBackground.self:SetText(self.prefix)
		return 
	end

	local weaponEntry = activeWeapon.weaponEntry
	local weaponName = nil
	if weaponEntry == nil then
		weaponName = self.prefix .. string.upper(activeWeapon.gameObject.name)
	else
		weaponName = self.prefix .. string.upper(weaponEntry.name)
	end

	self.targets.TextWithBackground.self:SetText(weaponName)
end
