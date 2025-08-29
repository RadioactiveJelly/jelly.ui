-- Register the behaviour
behaviour("AnimatedVehicleHealthBar")

function AnimatedVehicleHealthBar:Start()
	self.animatedBar = self.targets.AnimatedBar.self
	self.activeVehicle = nil
	self.script.AddValueMonitor("MonitorCurrentVehicle", "OnVehicleChange")
	self.script.AddValueMonitor("MonitorActiveVehicleHealth", "OnVehicleHealthChanged")
	self.script.AddValueMonitor("MonitorActiveVehicleMaxHealth", "OnVehicleMaxHealthChanged")
	self.animatedBar:Initialize(100, 100)
end

function AnimatedVehicleHealthBar:MonitorCurrentVehicle()
	if Player.actor == nil then return end

	return Player.actor.activeVehicle
end

function AnimatedVehicleHealthBar:OnVehicleChange(vehicle)
	local wasNil = false
	if self.activeVehicle == nil and vehicle then
		wasNil = true
	end

	self.activeVehicle = vehicle

	if vehicle == nil then return end

	self.animatedBar:SetMaxValue(vehicle.maxHealth)
	self.animatedBar:SnapToValue(vehicle.health)
end

function AnimatedVehicleHealthBar:MonitorActiveVehicleHealth()
	if self.activeVehicle == nil then return end

	return self.activeVehicle.health
end

function AnimatedVehicleHealthBar:OnVehicleHealthChanged(val)
	if val == nil then return end

	self.animatedBar:SetValue(val)
end

function AnimatedVehicleHealthBar:MonitorActiveVehicleMaxHealth()
	if self.activeVehicle == nil then return end

	return self.activeVehicle.maxHealth
end

function AnimatedVehicleHealthBar:OnVehicleMaxHealthChanged(val)
	if val == nil then return end

	self.animatedBar:SetMaxValue(val)
end