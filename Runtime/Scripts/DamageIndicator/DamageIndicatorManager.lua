--Spawns damage indicators when the player is damaged.
behaviour("DamageIndicatorManager")

function DamageIndicatorManager:Start()
	-- Run when behaviour is created
	Player.actor.onTakeDamage.AddListener(self,"onTakeDamage")

	self.liveIndicators = {}
	--self.pooledIndicators = {}

	self.indicatorPrefab = self.targets.DataContainer.GetGameObject("Indicator")

	self.affectedTeamActors = ActorManager.GetActorsOnTeam(Player.actor.team)

	GameObject.Find("Damage Indicator Mask").gameObject.SetActive(false)
end

function DamageIndicatorManager:Update()
	for botName, indicator in pairs(self.liveIndicators) do
		indicator.self:Tick(Player.actor.isDead)
		if indicator.self.isDead then
			self.liveIndicators[botName] = nil
			GameObject.Destroy(indicator.gameObject)
		end
	end
end

function DamageIndicatorManager:onTakeDamage(actor, source, info)
	if source and source ~= Player.actor and not Player.actor.isDead then
		self:CreateIndicator(source ,source.position)
	end
end

function DamageIndicatorManager:CreateIndicator(source ,targetPos)
	local indicator = nil
	if self.liveIndicators[source.name] then
		indicator = self.liveIndicators[source.name]
	else
		indicator = GameObject.Instantiate(self.indicatorPrefab).GetComponent(ScriptedBehaviour)
		indicator.gameObject.transform.SetParent(self.gameObject.transform, false)
		self.liveIndicators[source.name] = indicator
	end
	indicator.self:Init(targetPos)
end