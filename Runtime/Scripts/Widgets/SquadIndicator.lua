-- Register the behaviour
behaviour("SquadIndicator")

function SquadIndicator:Start()
	self.script.AddValueMonitor("MonitorPlayerSquad", "OnSquadCountChanged")
end

function SquadIndicator:MonitorPlayerSquad()
	if Player.actor == nil then return end
	if Player.squad == nil then return 0 end

	return #Player.squad.members - 1
end

function SquadIndicator:OnSquadCountChanged(count)
	if count == nil then return end

	if count == 0 then self.targets.Indicator.text = "NO SQUAD" return end

	self.targets.Indicator.text = "SQUAD: " .. count
end
