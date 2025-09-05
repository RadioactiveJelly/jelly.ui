-- Register the behaviour
behaviour("FireModeIndicator")

function FireModeIndicator:Start()
	self.script.AddValueMonitor("MonitorFireMode","OnFireModeChanged")
end

function FireModeIndicator:MonitorFireMode()
	if Player.actor == nil then return end
	if Player.actor.activeWeapon == nil then return nil end

	return Player.actor.activeWeapon.activeSubWeapon.isAuto
end

function FireModeIndicator:OnFireModeChanged(isAuto)
	if isAuto == nil then
		self.targets.FireMode.text = ""
		return
	end

	if isAuto then
		self.targets.FireMode.text = "FULL AUTO"
	else
		self.targets.FireMode.text = "SINGLE FIRE"
	end
end
