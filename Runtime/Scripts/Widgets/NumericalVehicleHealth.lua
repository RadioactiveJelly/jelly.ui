-- Register the behaviour
behaviour("NumericalVehicleHealth")

function NumericalVehicleHealth:Start()
	self.script.AddValueMonitor("MonitorCurrentVehicle", "OnVehicleChange")
	self.script.AddValueMonitor("MonitorActiveVehicleHealth", "OnVehicleHealthChanged")
	self.script.AddValueMonitor("MonitorActiveVehicleMaxHealth", "OnVehicleMaxHealthChanged")
	self.lowColor = self.targets.DataContainer.GetColor("LowColor")
	self.zeroColor = self.targets.DataContainer.GetColor("ZeroColor")
	self.digitLimit = self.targets.DataContainer.GetInt("MaxDigitLimit")
	self.displayMax = self.targets.DataContainer.GetFloat("DisplayMax")
	self.lowThreshold = self.targets.DataContainer.GetFloat("LowThreshold")
end

function NumericalVehicleHealth:MonitorCurrentVehicle()
	if Player.actor == nil then return end

	return Player.actor.activeVehicle
end

function NumericalVehicleHealth:OnVehicleChange(vehicle)
	self.activeVehicle = vehicle

	if vehicle == nil then return end

	self:UpdateMaxDigits()
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

	self:UpdateMaxDigits()
end

function NumericalVehicleHealth:GetDigits(num)
	num = Mathf.Ceil(num)
	return (num == 0) and 1 or Mathf.Floor(Mathf.Log10(Mathf.Abs(num))) + 1
end

function NumericalVehicleHealth:UpdateMaxDigits()
	self.maxDigits = self:GetDigits(self.activeVehicle.maxHealth)
	if self.maxDigits > self.digitLimit then self.maxDigits = self.digitLimit end
	
	self:UpdateDisplay()
end

function NumericalVehicleHealth:UpdateDisplay()
	local health = Mathf.Ceil(self.activeVehicle.health)
	health = Mathf.Clamp(health,0,self.displayMax)
	local digits = self:GetDigits(health)

	local t = health/self.activeVehicle.maxHealth

	local text = nil
	if t <= self.lowThreshold then
		local richTextTag = ColorScheme.RichTextColorTag(self.lowColor)
		text = richTextTag .. health .. "</color>"
	else
		text = health
	end

	local numZeroes = self.maxDigits - digits
	local prefix = ""
	for i = 1, numZeroes, 1 do
		prefix = prefix .. "0"
	end

	local zeroRichTextTag = ColorScheme.RichTextColorTag(self.zeroColor)

	self.targets.Number.text = zeroRichTextTag .. prefix .. "</color>" .. text
end