-- Register the behaviour
behaviour("NumericalAmmoDisplay")

function NumericalAmmoDisplay:Start()
	self.script.AddValueMonitor("MonitorActiveWeapon", "OnActiveWeaponChanged")
	self.script.AddValueMonitor("MonitorAmmoCount", "OnAmmoCountChanged")
	self.script.AddValueMonitor("MonitorMaxAmmoCount", "OnMaxAmmoChanged")
	self.lowColor = self.targets.DataContainer.GetColor("LowColor")
	self.normalColor = self.targets.DataContainer.GetColor("NormalColor")
	self.targets.NumericalDisplay.self:SetColor(self.normalColor)
end

function NumericalAmmoDisplay:MonitorActiveWeapon()
	if Player.actor == nil then return nil end
	if Player.actor.activeWeapon == nil then return nil end

	return Player.actor.activeWeapon.activeSubWeapon
end

function NumericalAmmoDisplay:OnActiveWeaponChanged(activeWeapon)
	if activeWeapon == nil then return end
	
	self.currentMaxAmmo = activeWeapon.maxAmmo
	local numericalDisplay = self.targets.NumericalDisplay.self
	numericalDisplay:SetMaximum(self.currentMaxAmmo)
end

function NumericalAmmoDisplay:MonitorAmmoCount()
	if Player.actor == nil then return end
	if Player.actor.activeWeapon == nil then return end

	return Player.actor.activeWeapon.activeSubWeapon.ammo
end

function NumericalAmmoDisplay:OnAmmoCountChanged(ammo)
	if ammo == nil or self.currentMaxAmmo == nil then self.targets.Number.text = "" return end

	local numericalDisplay = self.targets.NumericalDisplay.self

	if ammo == -1 then
		numericalDisplay:Empty()
		return
	end
	ammo = Mathf.Clamp(ammo,0,999)

	local t = ammo/self.currentMaxAmmo
	if t <= 0.35 then
		numericalDisplay:SetColor(self.lowColor)
	else
		numericalDisplay:SetColor(self.normalColor)
	end

	numericalDisplay:SetValue(ammo)
end

function NumericalAmmoDisplay:MonitorMaxAmmoCount()
	if Player.actor == nil then return end
	if Player.actor.activeWeapon == nil then return end

	return Player.actor.activeWeapon.activeSubWeapon.maxAmmo
end

function NumericalAmmoDisplay:OnMaxAmmoChanged(val)
	if val == nil then return end

	local numericalDisplay = self.targets.NumericalDisplay.self
	numericalDisplay:SetMaximum(val)
end
