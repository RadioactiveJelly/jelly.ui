--Displays the UI sprite of the gear slot the widget is assigned to.
--Also displays the amount of ammo left the gear in the slot has.
--When QuickThrow is active, will also show keybinds if applicable.
behaviour("GearWidget")

function GearWidget:Start()
	self.targetSlot = self.targets.DataContainer.GetInt("GearSlot")
	self.targets.CanvasGroup.alpha = 0
	self.gear = nil 
	self.script.AddValueMonitor("MonitorGearSlot", "OnGearSlotChanged")
	self.script.AddValueMonitor("MonitorGearAmmo", "OnAmmoChanged")
	self.targets.KeybindHolder.SetActive(false)
	self.script.StartCoroutine(self:FindQuickThrow())
end

function GearWidget:MonitorGearSlot()
	if Player.actor == nil then return nil end
	if self.targetSlot > 5 then return nil end

	local gear = Player.actor.weaponSlots[self.targetSlot]
	return gear
end

function GearWidget:OnGearSlotChanged(gear)
	self.gear = gear

	if self.gear == nil then
		self.targets.CanvasGroup.alpha = 0 
		return 
	end

	self.targets.CanvasGroup.alpha = 1

	local weaponEntry = gear.weaponEntry
	if weaponEntry == nil then return end

	self.targets.Image.sprite = weaponEntry.uiSprite

	if self.quickThrow then
		local quickThrowable = self.quickThrow.self:isValidWeapon(gear)
		self.targets.KeybindHolder.SetActive(quickThrowable)
	end
	
end

function GearWidget:MonitorGearAmmo()
	if self.gear == nil then return nil end
	
	if self.gear.spareAmmo > 0 then
		return self.gear.spareAmmo + self.gear.ammo
	end

	return self.gear.ammo
end

function GearWidget:OnAmmoChanged(ammo)
	if ammo == nil or ammo <= -1 then self.targets.Ammo.text = "" return end

	self.targets.Ammo.text = ammo
end

function GearWidget:FindQuickThrow()
	return function()
		coroutine.yield(WaitForSeconds(0.25))
		local quickThrowObj = self.gameObject.find("QuickThrow")
		if quickThrowObj then
			self.quickThrow = quickThrowObj.GetComponent(ScriptedBehaviour)
			if self.quickThrow then
				self:UpdateKeybind()
			end
		end
	end
end

function GearWidget:UpdateKeybind()
	if self.quickThrow == nil then return end

	local keybinds = self.quickThrow.self.keybinds
	local quickThrowSlot = self.targetSlot - 2
	local text = nil
	if string.find(keybinds[quickThrowSlot], "mouse") then
		local num = nil
		for word in string.gmatch(keybinds[quickThrowSlot], '%S+') do
			num = word
		end
		if num then
			text = "M" .. num
		end
	else
		text = keybinds[quickThrowSlot]
	end

	if text == nil then return end

	self.targets.Keybind.text = string.upper(text)
end