-- Register the behaviour
behaviour("AnimatedArmorBar")

function AnimatedArmorBar:Start()
	self.animatedBar = self.gameObject.GetComponent(AnimatedBar)
	self.script.StartCoroutine(self:DelayedStart())
end

function AnimatedArmorBar:DelayedStart()
	return function()
		coroutine.yield(nil)
		local armorObj = self.gameObject.Find("PlayerArmor")
		if armorObj then
			self.playerArmor = armorObj.GetComponent(ScriptedBehaviour)
			self.script.AddValueMonitor("MonitorCurrentArmorHealth","OnArmorHealthChanged")
			self.script.AddValueMonitor("MonitorMaxArmorHealth","OnMaxArmorHealthChanged")
			self.animatedBar:Initialize(self.playerArmor.self.startingArmorHealth, self.playerArmor.self.maxArmorHealth)
		else
			self.animatedBar:Initialize(0,100)
		end
	end
end

function AnimatedArmorBar:MonitorCurrentArmorHealth()
	if self.playerArmor == nil then return end

	return self.playerArmor.self.armorHealth
end

function AnimatedArmorBar:OnArmorHealthChanged(val)
	if val == nil then return end

	self.animatedBar:SetValue(val)
end

function AnimatedArmorBar:MonitorMaxArmorHealth()
	if self.playerArmor == nil then return end

	return self.playerArmor.self.maxArmorHealth
end

function AnimatedArmorBar:OnMaxArmorHealthChanged(val)
	if val == nil then return end

	self.animatedBar:SetMaxValue(val)
end