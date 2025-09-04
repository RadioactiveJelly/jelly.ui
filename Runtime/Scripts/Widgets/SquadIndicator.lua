-- Register the behaviour
behaviour("SquadIndicator")

function SquadIndicator:Start()
	self.squadCount = 0
	self.squadOrder = ""

	GameEvents.onActorSpawn.AddListener(self,"OnActorSpawn")
	self.hasSpawned = false
	self.targets.SquadOrder.text = ""
end

function SquadIndicator:OnActorSpawn(actor)
	if not actor.isPlayer then return end
	if self.hasSpawned then return end

	self.script.AddValueMonitor("MonitorPlayerSquad", "OnSquadCountChanged")
	self.script.AddValueMonitor("MonitorPlayerOrderState", "OnSquadOrderChanged")
	self.squadOrder = string.upper(tostring(PlayerHud.playerOrderState))
	
	self.hasSpawned = true
end

function SquadIndicator:MonitorPlayerSquad()
	if Player.actor == nil then return end
	if Player.squad == nil then return 0 end

	return #Player.squad.members - 1
end

function SquadIndicator:MonitorPlayerOrderState()
	if PlayerHud == nil then return end

	return PlayerHud.playerOrderState
end

function SquadIndicator:OnSquadCountChanged(count)
	if count == nil then return end

	self.squadCount = count
	self:UpdateText()
end


function SquadIndicator:OnSquadOrderChanged(order)
	if order == nil then return end

	self.squadOrder = string.upper(tostring(order))
	self:UpdateText()
end

function SquadIndicator:UpdateText()
	local text = "NO SQUAD"
	
	if self.squadCount > 0 then
		self.targets.SquadCount.text = "SQUAD: " .. self.squadCount
		self.targets.SquadOrder.text = self.squadOrder
	else
		self.targets.SquadCount.text = "NO SQUAD"
		self.targets.SquadOrder.text = ""
	end
end
