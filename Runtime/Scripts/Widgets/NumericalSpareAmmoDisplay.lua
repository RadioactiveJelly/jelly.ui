-- Register the behaviour
behaviour("NumericalSpareAmmoDisplay")

function NumericalSpareAmmoDisplay:Start()
	self.script.AddValueMonitor("MonitorActiveWeapon", "OnActiveWeaponChanged")
	self.script.AddValueMonitor("MonitorAmmoCount", "OnAmmoCountChanged")
	self.script.AddValueMonitor("MonitorMaxSpareAmmoCount", "OnMaxSpareAmmoChanged")
	self.lowColor = self.targets.DataContainer.GetColor("LowColor")
	self.normalColor = self.targets.DataContainer.GetColor("NormalColor")
	self.targets.NumericalDisplay.self:SetColor(self.normalColor)
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
	if spareAmmo == nil or self.currentMaxSpareAmmo == nil then self.targets.Number.text = "" return end

	if spareAmmo == -1 then
		numericalDisplay:ForceText("")
		return
	elseif spareAmmo == -2 then
		numericalDisplay:ForceText("∞")
		return
	end

	local numericalDisplay = self.targets.NumericalDisplay.self
	local t = spareAmmo/self.currentMaxSpareAmmo
	if t <= 0.35 then
		numericalDisplay:SetColor(self.lowColor)
	else
		numericalDisplay:SetColor(self.normalColor)
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