--Uses NumericalDisplay to display the health of the player
behaviour("NumericalHealth")

function NumericalHealth:Start()
	if Player.actor == nil then return end

	self.script.AddValueMonitor("MonitorPlayerHealth", "OnPlayerHealthChanged")
	self.script.AddValueMonitor("MonitorPlayerMaxHealth", "OnPlayerMaxHealthChanged")
	self.lowColor = self.targets.DataContainer.GetColor("LowColor")
	self.defaultColor = self.targets.DataContainer.GetColor("DefaultColor")
	self.lowThreshold = self.targets.DataContainer.GetFloat("LowThreshold")
	GameEvents.onActorSpawn.AddListener(self,"OnActorSpawn")
	self.targets.NumericalDisplay.self:SetColor(self.defaultColor)
end

function NumericalHealth:MonitorPlayerHealth()
	if Player.actor == nil then return end

	return Player.actor.health
end

function NumericalHealth:OnPlayerHealthChanged(val)
	if val == nil then return end

	self:UpdateDisplay()
end

function NumericalHealth:MonitorPlayerMaxHealth()
	if Player.actor == nil then return end

	return Player.actor.maxHealth
end

function NumericalHealth:OnPlayerMaxHealthChanged(val)
	if val == nil then return end

	self.targets.NumericalDisplay.self:SetMaximum(val)
end

function NumericalHealth:OnActorSpawn(actor)
	if not actor.isPlayer then return end

	self.targets.NumericalDisplay.self:SetMaximum(actor.maxHealth)
	self:UpdateDisplay()
end

function NumericalHealth:UpdateDisplay()
	local t = Player.actor.health/Player.actor.maxHealth
	local numericalDisplay = self.targets.NumericalDisplay.self

	if t <= self.lowThreshold then
		numericalDisplay:SetColor(self.lowColor)
	else
		numericalDisplay:SetColor(self.defaultColor)
	end
	numericalDisplay:SetValue(Player.actor.health)
end