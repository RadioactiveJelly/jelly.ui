--Uses the AnimatedBar script to display the player's current health
behaviour("AnimatedHealthBar")

function AnimatedHealthBar:Start()
	if Player.actor == nil then return end

	self.animatedBar = self.gameObject.GetComponent(AnimatedBar)
	self.animatedBar:Initialize(Player.actor.health, Player.actor.maxHealth)
	self.script.AddValueMonitor("MonitorPlayerHealth", "OnPlayerHealthChanged")
	self.script.AddValueMonitor("MonitorPlayerMaxHealth", "OnPlayerMaxHealthChanged")
	GameEvents.onActorSpawn.AddListener(self,"OnActorSpawn")
end

function AnimatedHealthBar:MonitorPlayerHealth()
	if Player.actor == nil then return end

	return Player.actor.health
end

function AnimatedHealthBar:OnPlayerHealthChanged(val)
	if val == nil then return end

	self.animatedBar:SetValue(val)
end

function AnimatedHealthBar:MonitorPlayerMaxHealth()
	if Player.actor == nil then return end

	return Player.actor.maxHealth
end

function AnimatedHealthBar:OnPlayerMaxHealthChanged(val)
	if val == nil then return end

	self.animatedBar:SetMaxValue(val)
end

function AnimatedHealthBar:OnActorSpawn(actor)
	if not actor.isPlayer then return end

	self.animatedBar:SnapToValue(actor.health)
end
