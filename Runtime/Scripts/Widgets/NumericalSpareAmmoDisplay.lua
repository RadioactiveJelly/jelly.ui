--Uses NumericalDisplay to display the spare ammo count of the player's current weapon.
behaviour("NumericalSpareAmmoDisplay")

function NumericalSpareAmmoDisplay:Start()
	self.script.AddValueMonitor("MonitorActiveWeapon", "OnActiveWeaponChanged")
	self.script.AddValueMonitor("MonitorAmmoCount", "OnAmmoCountChanged")
	self.script.AddValueMonitor("MonitorMaxSpareAmmoCount", "OnMaxSpareAmmoChanged")
	self.lowColor = self.targets.DataContainer.GetColor("LowColor")
	self.defaultColor = self.targets.DataContainer.GetColor("DefaultColor")
	self.targets.NumericalDisplay.self:SetColor(self.defaultColor)
end

function NumericalSpareAmmoDisplay:MonitorActiveWeapon()
	if Player.actor == nil then return nil end
	if Player.actor.activeWeapon == nil then return nil end

	return Player.actor.activeWeapon.activeSubWeapon
end

function NumericalSpareAmmoDisplay:OnActiveWeaponChanged(activeWeapon)
	if activeWeapon == nil then return end
	
	self.currentMaxSpareAmmo = activeWeapon.maxSpareAmmo
	local numericalDisplay = self.targets.NumericalDisplay.self
	numericalDisplay:SetMaximum(self.currentMaxSpareAmmo)
end

function NumericalSpareAmmoDisplay:MonitorAmmoCount()
	if Player.actor == nil then return end
	if Player.actor.activeWeapon == nil then return end

	return Player.actor.activeWeapon.activeSubWeapon.spareAmmo
end

function NumericalSpareAmmoDisplay:OnAmmoCountChanged(spareAmmo)
	local numericalDisplay = self.targets.NumericalDisplay.self
	if spareAmmo == nil or self.currentMaxSpareAmmo == nil then numericalDisplay:ForceText("") return end

	if spareAmmo == -1 then
		numericalDisplay:ForceText("")
		return
	elseif spareAmmo == -2 then
		numericalDisplay:ForceText("∞")
		return
	end
	
	local t = spareAmmo/self.currentMaxSpareAmmo
	if t <= 0.35 then
		numericalDisplay:SetColor(self.lowColor)
	else
		numericalDisplay:SetColor(self.defaultColor)
	end

	numericalDisplay:SetValue(spareAmmo)
end

function NumericalSpareAmmoDisplay:MonitorMaxAmmoCount()
	if Player.actor == nil then return end
	if Player.actor.activeWeapon == nil then return end

	return Player.actor.activeWeapon.activeSubWeapon.maxSpareAmmo
end

function NumericalSpareAmmoDisplay:OnMaxAmmoChanged(val)
	if val == nil then return end

	local numericalDisplay = self.targets.NumericalDisplay.self
	numericalDisplay:SetMaximum(val)
end