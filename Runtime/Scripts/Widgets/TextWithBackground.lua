-- Register the behaviour
behaviour("TextWithBackground")

function TextWithBackground:SetText(text)
	self.targets.DummyLabel.text = text
	self.targets.Label.text = text
end
