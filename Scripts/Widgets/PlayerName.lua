-- Register the behaviour
behaviour("PlayerName")

function PlayerName:Start()
	if Player.actor == nil then return end

	self:SetName(Player.actor.name)
	self.script.AddValueMonitor("MonitorPlayerName", "OnPlayerNameChanged")
end

function PlayerName:MonitorPlayerName()
	if Player.actor == nil then return nil end

	return Player.actor.name
end

function PlayerName:OnPlayerNameChanged(name)
	if name == nil then return end

	self:SetName(name)
end

function PlayerName:SetName(name)
	if self.targets.DataContainer.GetBool("AllCaps") then
		name = string.upper(name)
	end
	self.targets.Name.text = name
end