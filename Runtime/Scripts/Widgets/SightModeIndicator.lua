--Simple script that displays the player's current weapon sight mode using a TMPRO_UGUI object.
behaviour("SightModeIndicator")

function SightModeIndicator:Awake()
	if GameManager.buildNumber <= 26 then
		self.sightText = GameObject.Find("Sight Text").GetComponent(Text)
	else
		self.sightText = GameObject.Find("Scope Text").GetComponent(Text)
	end

	if self.sightText == nil then return end

	self.script.AddValueMonitor("MonitorSightModeText","OnSightModeText")
end

function SightModeIndicator:MonitorSightModeText()
	if self.sightText == nil then return nil end

	return self.sightText.text
end

function SightModeIndicator:OnSightModeText(text)
	if text == nil then text = "" end

	self.targets.SightMode.text = text
end