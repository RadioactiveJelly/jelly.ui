-- Register the behaviour
behaviour("NumericalAmmoDisplay")

function NumericalAmmoDisplay:Start()
	self.script.AddValueMonitor("MonitorActiveWeapon", "OnActiveWeaponChanged")
	self.script.AddValueMonitor("MonitorAmmoCount", "OnAmmoCountChanged")
	self.lowColor = self.targets.DataContainer.GetColor("LowColor")
end

function NumericalAmmoDisplay:MonitorActiveWeapon()
	if Player.actor == nil then return nil end
	if Player.actor.activeWeapon == nil then return nil end

	return Player.actor.activeWeapon.activeSubWeapon
end

function NumericalAmmoDisplay:OnActiveWeaponChanged(activeWeapon)
	if activeWeapon == nil then return end
	
	self.currentMaxAmmo = activeWeapon.maxAmmo
end

function NumericalAmmoDisplay:MonitorAmmoCount()
	if Player.actor == nil then return end
	if Player.actor.activeWeapon == nil then return end

	return Player.actor.activeWeapon.activeSubWeapon.ammo
end

function NumericalAmmoDisplay:OnAmmoCountChanged(ammo)
	if ammo == nil or self.currentMaxAmmo == nil then self.targets.Number.text = "" return end

	if ammo == -1 then
		self.targets.Number.text = ""
		return
	end
	ammo = Mathf.Clamp(ammo,0,999)

	local t = ammo/self.currentMaxAmmo
	if t <= 0.35 then
		local color = self.lowColor
		local richTextTag = ColorScheme.RichTextColorTag(color)
		self.targets.Number.text = richTextTag .. ammo .. "</color>"
	else
		self.targets.Number.text = ammo
	end
end
