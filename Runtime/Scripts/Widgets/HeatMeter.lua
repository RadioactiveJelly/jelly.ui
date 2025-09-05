--A simple meter script to display the current weapon's heat values
behaviour("HeatMeter")

function HeatMeter:Start()
	self.targets.CanvasGroup.alpha = 0
	
	self.script.AddValueMonitor("MonitorActiveWeapon", "OnActiveWeaponChanged")
	self.script.AddValueMonitor("MonitorHeat", "OnHeatChanged")
end

function HeatMeter:MonitorActiveWeapon()
	if Player.actor == nil then return nil end
	if Player.actor.activeWeapon == nil then return nil end

	return Player.actor.activeWeapon.activeSubWeapon
end

function HeatMeter:OnActiveWeaponChanged(activeWeapon)
	if activeWeapon == nil then return end
	
	self.usingHeat = activeWeapon.applyHeat
	if self.usingHeat then 
		self.targets.CanvasGroup.alpha = 1
	else
		self.targets.CanvasGroup.alpha = 0
	end
end

function HeatMeter:MonitorHeat()
	if Player.actor == nil then return nil end
	if Player.actor.activeWeapon == nil then return end
	if not self.usingHeat then return nil end

	return Player.actor.activeWeapon.activeSubWeapon.heat
end

function HeatMeter:OnHeatChanged(heat)
	if heat == nil then return end

	self.targets.Meter.fillAmount = heat
end