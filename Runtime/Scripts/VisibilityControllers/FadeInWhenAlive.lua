--Fades in the target CanvasGroup when the actor is alive.
--Fades out when the actor is dead.
behaviour("FadeInWhenAlive")

function FadeInWhenAlive:Start()
	self.targets.CanvasGroup.alpha = 0
	self.fadeTime = self.targets.DataContainer.GetFloat("FadeTime")
	GameEvents.onActorDiedInfo.AddListener(self, "OnActorDied")
	GameEvents.onActorSpawn.AddListener(self,"OnActorSpawn")
end

function FadeInWhenAlive:OnActorDied(actor, info, silent)
	if not actor.isPlayer then return end

	self.script.StartCoroutine(self:FadeOut())
end

function FadeInWhenAlive:OnActorSpawn(actor)
	if not actor.isPlayer then return end

	self.script.StartCoroutine(self:FadeIn())
end


function FadeInWhenAlive:FadeIn()
	return function()
		local canvasGroup = self.targets.CanvasGroup
		local timer = self.fadeTime * canvasGroup.alpha
		while timer <= self.fadeTime and not Player.actor.isDead do
			local t = timer/self.fadeTime
			canvasGroup.alpha = t
			timer = timer + Time.deltaTime
			coroutine.yield()
		end
	end
end

function FadeInWhenAlive:FadeOut()
	return function()
		local canvasGroup = self.targets.CanvasGroup
		local timer = self.fadeTime * (1-canvasGroup.alpha)
		while timer <= self.fadeTime and Player.actor.isDead do
			local t = timer/self.fadeTime
			canvasGroup.alpha = 1 - t
			timer = timer + Time.deltaTime
			coroutine.yield()
		end
	end
end
