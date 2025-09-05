--TMPRO_UGUI based display for the player's current vehicle name.
behaviour("ActiveVehicleName")

function ActiveVehicleName:Start()
	self.script.AddValueMonitor("MonitorCurrentVehicle", "OnVehicleChange")
end

function ActiveVehicleName:MonitorCurrentVehicle()
	if Player.actor == nil then return end

	return Player.actor.activeVehicle
end

function ActiveVehicleName:OnVehicleChange(vehicle)
	if vehicle == nil then 
		return 
	end

	self.targets.Name.text = vehicle.name
end
