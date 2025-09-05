--Scrolls a RawImage based on the values given on the DataContainer
behaviour("RawImageScroller")

function RawImageScroller:Start()
	self.yScrollSpeed = self.targets.DataContainer.GetFloat("yScrollSpeed")
	self.xScrollSpeed = self.targets.DataContainer.GetFloat("xScrollSpeed")
	self.rawImage = self.targets.RawImage
end

function RawImageScroller:Update()
	local uvRect = self.rawImage.uvRect
	uvRect.y = uvRect.y + (self.yScrollSpeed * Time.deltaTime) % 1
	uvRect.x = uvRect.x + (self.xScrollSpeed * Time.deltaTime) % 1
	self.rawImage.uvRect = uvRect
end
