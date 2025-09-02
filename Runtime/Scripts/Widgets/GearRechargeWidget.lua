-- Register the behaviour
behaviour("GearRechargeWidget")

function GearRechargeWidget:Start()
	self.targetSlot = self.targets.DataContainer.GetInt("GearSlot")
	self.targets.CanvasGroup.alpha = 0
	self.gear = nil 
	
	self.script.StartCoroutine(self:FindGearRecharge())
end

function GearRechargeWidget:FindGearRecharge()
	return function()
		local maxAttempts = 30
		local numAttempts = 0
		while numAttempts < maxAttempts and self.gearRecharge == nil do
			coroutine.yield(nil)
			local gcObject = self.gameObject.Find("GearRecharge")
			if gcObject then
				self.gearRecharge = gcObject.GetComponent(ScriptedBehaviour)
				self.script.AddValueMonitor("MonitorGearSlot", "OnGearSlotChanged")
				self.script.AddValueMonitor("MonitorGearCharge", "OnGearChargeChange")
				self.script.AddValueMonitor("MonitorGearRequiredCharge", "OnGearRequiredChargeChange")
				self.targets.AnimatedBar.self:Initialize(100,100)
			end
			numAttempts = numAttempts + 1
		end
	end
end

function GearRechargeWidget:MonitorGearSlot()
	if Player.actor == nil then return nil end
	if self.targetSlot > 5 then return nil end

	local gear = self.gearRecharge.self.activeGear[self.targetSlot]
	return gear
end

function GearRechargeWidget:OnGearSlotChanged(gear)
	self.gear = gear

	if self.gear == nil then
		self.targets.CanvasGroup.alpha = 0 
		return 
	end
	
	self.targets.CanvasGroup.alpha = 1
	self.targets.AnimatedBar.self:SetMaxValue(gear.rechargeRequirement)
	self.targets.AnimatedBar.self:SnapToValue(gear.currentCharge)
end

function GearRechargeWidget:MonitorGearCharge()
	if self.gear == nil then return end

	return self.gear.currentCharge
end

function GearRechargeWidget:OnGearChargeChange(val)
	if val == nil then return end

	self.targets.AnimatedBar.self:SetValue(val)
end

function GearRechargeWidget:MonitorGearRequiredCharge()
	if self.gear == nil then return end

	return self.gear.rechargeRequirement
end

function GearRechargeWidget:OnGearRequiredChargeChange(val)
	if val == nil then return end

	self.targets.AnimatedBar.self:SetMaxValue(val)
end