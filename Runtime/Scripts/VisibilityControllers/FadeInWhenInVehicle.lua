--Fades in when the player is in a vehicle
--Fades out when the player exits the vehicle
behaviour("FadeInWhenInVehicle")

function FadeInWhenInVehicle:Start()
	self.targets.CanvasGroup.alpha = 0
	self.fadeTime = self.targets.DataContainer.GetFloat("FadeTime")
	self.script.AddValueMonitor("MonitorCurrentVehicle", "OnVehicleChange")
	self.activeVehicle = nil
end

function FadeInWhenInVehicle:MonitorCurrentVehicle()
	if Player.actor == nil then return end

	return Player.actor.activeVehicle
end

function FadeInWhenInVehicle:OnVehicleChange(vehicle)
	self.activeVehicle = vehicle
	if vehicle then 
		self.script.StartCoroutine(self:FadeIn()) 
	else
		self.script.StartCoroutine(self:FadeOut()) 
	end
end

function FadeInWhenInVehicle:FadeIn()
	return function()
		local canvasGroup = self.targets.CanvasGroup
		local timer = self.fadeTime * canvasGroup.alpha
		while timer <= self.fadeTime and self.activeVehicle ~= nil do
			local t = timer/self.fadeTime
			canvasGroup.alpha = t
			timer = timer + Time.deltaTime
			coroutine.yield()
		end
	end
end

function FadeInWhenInVehicle:FadeOut()
	return function()
		local canvasGroup = self.targets.CanvasGroup
		local timer = self.fadeTime * (1-canvasGroup.alpha)
		while timer <= self.fadeTime and self.activeVehicle == nil do
			local t = timer/self.fadeTime
			canvasGroup.alpha = 1 - t
			timer = timer + Time.deltaTime
			coroutine.yield()
		end
	end
end
