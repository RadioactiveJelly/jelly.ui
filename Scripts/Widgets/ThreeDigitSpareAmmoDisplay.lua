-- Register the behaviour
behaviour("ThreeDigitSpareAmmoDisplay")

function ThreeDigitSpareAmmoDisplay:Start()
	self.script.AddValueMonitor("MonitorActiveWeapon", "OnActiveWeaponChanged")
	self.script.AddValueMonitor("MonitorAmmoCount", "OnAmmoCountChanged")
	self.lowColor = self.targets.DataContainer.GetColor("LowColor")
	self.zeroColor = self.targets.DataContainer.GetColor("ZeroColor")
	self.maxDigits = 3
end

function ThreeDigitSpareAmmoDisplay:MonitorActiveWeapon()
	if Player.actor == nil then return nil end

	return Player.actor.activeWeapon
end

function ThreeDigitSpareAmmoDisplay:OnActiveWeaponChanged(activeWeapon)
	if activeWeapon == nil then return end
	
	self.currentMaxSpareAmmo = activeWeapon.maxSpareAmmo
end

function ThreeDigitSpareAmmoDisplay:MonitorAmmoCount()
	if Player.actor == nil then return end
	if Player.actor.activeWeapon == nil then return end

	return Player.actor.activeWeapon.spareAmmo
end

function ThreeDigitSpareAmmoDisplay:OnAmmoCountChanged(spareAmmo)
	if spareAmmo == nil then return end

	if spareAmmo == -1 then
		self.targets.Number.text = ""
		return
	elseif spareAmmo == -2 then
		self.targets.Number.text = "∞"
		return
	end
	spareAmmo = Mathf.Clamp(spareAmmo,0,999)

	local digitCount = #tostring(Mathf.Abs(spareAmmo))
	local t = spareAmmo/self.currentMaxSpareAmmo
	local text = nil
	if t <= 0.35 then
		local richTextTag = ColorScheme.RichTextColorTag(self.lowColor)
		text = richTextTag .. spareAmmo .. "</color>"
	else
		text = spareAmmo
	end

	local numZeroes = self.maxDigits - digitCount
	local prefix = ""
	for i = 1, numZeroes, 1 do
		prefix = prefix .. "0"
	end

	local zeroRichTextTag = ColorScheme.RichTextColorTag(self.zeroColor)

	self.targets.Number.text = zeroRichTextTag .. prefix .. "</color>" .. text
end
