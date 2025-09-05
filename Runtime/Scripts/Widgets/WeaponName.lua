--Displays the current player's weapon name
behaviour("WeaponName")

function WeaponName:Start()
	self.script.AddValueMonitor("MonitorActiveWeapon", "OnActiveWeaponChanged")
end

function WeaponName:MonitorActiveWeapon()
	if Player.actor == nil then return nil end
	if Player.actor.activeWeapon == nil then return nil end

	return Player.actor.activeWeapon.activeSubWeapon
end

function WeaponName:OnActiveWeaponChanged(activeWeapon)
	if activeWeapon == nil then
		self.targets.Label.text = ""
		return 
	end

	local weaponEntry = activeWeapon.weaponEntry
	local weaponName = nil
	if weaponEntry == nil then
		weaponName = string.upper(activeWeapon.gameObject.name)
	else
		weaponName = string.upper(weaponEntry.name)
	end

	self.targets.Label.text = weaponName
end
