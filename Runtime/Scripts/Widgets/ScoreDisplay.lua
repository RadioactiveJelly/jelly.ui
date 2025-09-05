--Displays the player's current score from ScoreSystem in real time.
--Also displays the player's current multiplier
--Uses TMPRO_UGUI
behaviour("ScoreDisplay")

function ScoreDisplay:Start()
	self.targets.CanvasGroup.alpha = 0
	self.script.StartCoroutine(self:DelayedStart())
end

function ScoreDisplay:DelayedStart()
	return function()
		local maxAttempts = 30
		local numAttempts = 0
		while numAttempts < maxAttempts and self.scoreSystem == nil do
			coroutine.yield(nil)
			local scoreSystemObj = self.gameObject.Find("Score System")
			if scoreSystemObj then
				self.scoreSystem = scoreSystemObj.GetComponent(ScriptedBehaviour)
				self.script.AddValueMonitor("MonitorTotalPoints", "OnTotalPointsChanged")
				self.script.AddValueMonitor("MonitorMultiplier", "OnMultiplierChanged")
				self.targets.CanvasGroup.alpha = 1
				self.targets.AnimatedNumber.self:SnapToValue(0)
				self.targets.Multiplier.text = "MULTIPLIER: x1"
			end
			numAttempts = numAttempts + 1
		end
	end
end

function ScoreDisplay:MonitorTotalPoints()
	if self.scoreSystem == nil then return end

	return self.scoreSystem.self.totalPoints
end

function ScoreDisplay:OnTotalPointsChanged(totalPoints)
	if totalPoints == nil then return end

	self.targets.AnimatedNumber.self:SetValue(totalPoints)
end

function ScoreDisplay:MonitorMultiplier()
	if self.scoreSystem == nil then return end

	return self.scoreSystem.self.scoreMultiplier
end

function ScoreDisplay:OnMultiplierChanged(multiplier)
	if multiplier == nil then return end

	self.targets.Multiplier.text = "MULTIPLIER: x" .. multiplier
end

