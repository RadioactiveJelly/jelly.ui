--Displays the player's armor plates from Player Armor
--Also shows the keybind to use armor plates
behaviour("ArmorPlateDisplay")

function ArmorPlateDisplay:Start()
	self.script.StartCoroutine(self:DelayedStart())
end

function ArmorPlateDisplay:DelayedStart()
	return function()
		coroutine.yield(nil)
		local armorObj = self.gameObject.Find("PlayerArmor")
		if armorObj then
			self.playerArmor = armorObj.GetComponent(ScriptedBehaviour)
			self.targets.Keybind.text = string.upper(self.playerArmor.self.armorPlateKeybind)
			self.script.AddValueMonitor("MonitorArmorPlateCount","OnArmorPlateCountChanged")
		else
			self.gameObject.SetActive(false)
		end
	end
end

function ArmorPlateDisplay:MonitorArmorPlateCount()
	if self.playerArmor == nil then return end

	return self.playerArmor.self.currentArmorPlateCount
end

function ArmorPlateDisplay:OnArmorPlateCountChanged(val)
	if val == nil then return end

	self.targets.PlateCount.text = val
end