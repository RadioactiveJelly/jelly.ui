-- Register the behaviour
behaviour("ShowWhenAlive")

function ShowWhenAlive:Start()
	self.targets.CanvasGroup.alpha = 0
	GameEvents.onActorDiedInfo.AddListener(self, "OnActorDied")
	GameEvents.onActorSpawn.AddListener(self,"OnActorSpawn")
end

function ShowWhenAlive:OnActorDied(actor, info, silent)
	if not actor.isPlayer then return end

	self.targets.CanvasGroup.alpha = 0
end

function ShowWhenAlive:OnActorSpawn(actor)
	if not actor.isPlayer then return end

	self.targets.CanvasGroup.alpha = 1
end
