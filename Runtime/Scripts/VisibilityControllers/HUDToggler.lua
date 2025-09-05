--Sets the visibility of the target canvas group based on the hudPlayerEnabled boolean
behaviour("HUDToggler")

function HUDToggler:Start()
	self.script.AddValueMonitor("MonitorHudVisibility", "OnVisibilityChanged")
end

function HUDToggler:MonitorHudVisibility()
	return GameManager.hudPlayerEnabled
end

function HUDToggler:OnVisibilityChanged(isVisible)
	local alpha = 0
	if isVisible then alpha = 1 end
	self.targets.CanvasGroup.alpha = alpha
end
