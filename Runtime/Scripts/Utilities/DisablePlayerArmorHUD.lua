--Disables the PlayerArmor HUD
behaviour("DisablePlayerArmorHUD")

function DisablePlayerArmorHUD:Start()
	self.script.StartCoroutine(self:DelayedStart())
end

function DisablePlayerArmorHUD:DelayedStart()
	return function()
		coroutine.yield(nil)
		local armorObj = self.gameObject.Find("PlayerArmor")
		if armorObj then
			self.playerArmor = armorObj.GetComponent(ScriptedBehaviour)
			self.playerArmor.self:DisableHUD()
		end
	end
end
