-- Register the behaviour
behaviour("DisableQuickThrowHUD")

function DisableQuickThrowHUD:Start()
	self.script.StartCoroutine(self:DisableQuickThrowHUD())
end

function DisableQuickThrowHUD:DisableQuickThrowHUD()
	return function()
		coroutine.yield(nil)
		local quickThrowObj = self.gameObject.find("QuickThrow")
		if quickThrowObj then
			self.quickThrow = quickThrowObj.GetComponent(ScriptedBehaviour)
			if self.quickThrow then
				self.quickThrow.self:ToggleHUD(false)
			end
		end
	end
end
