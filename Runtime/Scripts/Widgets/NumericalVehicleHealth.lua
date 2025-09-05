--Uses NumericalDisplay to display the health of the player's current vehicle.
behaviour("NumericalVehicleHealth")

function NumericalVehicleHealth:Start()
	self.script.AddValueMonitor("MonitorCurrentVehicle", "OnVehicleChange")
	self.script.AddValueMonitor("MonitorActiveVehicleHealth", "OnVehicleHealthChanged")
	self.script.AddValueMonitor("MonitorActiveVehicleMaxHealth", "OnVehicleMaxHealthChanged")
	self.lowColor = self.targets.DataContainer.GetColor("LowColor")
	self.zeroColor = self.targets.DataContainer.GetColor("ZeroColor")
	self.defaultColor = self.targets.DataContainer.GetColor("DefaultColor")
	self.lowThreshold = self.targets.DataContainer.GetFloat("LowThreshold")
	self.targets.NumericalDisplay.self:SetColor(self.defaultColor)
end

function NumericalVehicleHealth:MonitorCurrentVehicle()
	if Player.actor == nil then return end

	return Player.actor.activeVehicle
end

function NumericalVehicleHealth:OnVehicleChange(vehicle)
	self.activeVehicle = vehicle

	if self.activeVehicle == nil then return end

	self.targets.NumericalDisplay.self:SetMaximum(self.activeVehicle.maxHealth)
end

function NumericalVehicleHealth:MonitorActiveVehicleHealth()
	if self.activeVehicle == nil then return end

	return self.activeVehicle.health
end

function NumericalVehicleHealth:OnVehicleHealthChanged(val)
	if val == nil then return end

	self:UpdateDisplay()
end

function NumericalVehicleHealth:MonitorActiveVehicleMaxHealth()
	if self.activeVehicle == nil then return end

	return self.activeVehicle.maxHealth
end

function NumericalVehicleHealth:OnVehicleMaxHealthChanged(val)
	if val == nil then return end

	self.targets.NumericalDisplay.self:SetMaximum(val)
end

function NumericalVehicleHealth:UpdateDisplay()
	local t = self.activeVehicle.health/self.activeVehicle.maxHealth
	local numericalDisplay = self.targets.NumericalDisplay.self

	if t <= self.lowThreshold then
		numericalDisplay:SetColor(self.lowColor)
	else
		numericalDisplay:SetColor(self.defaultColor)
	end
	numericalDisplay:SetValue(self.activeVehicle.health)
end