--A simple script for a TMPRO_UGUI with a scaling background
--DummyLabel must be at the root of the object.
--The root object must have a content size fitter.
--The background object must be a child of the DummyLabel
--The Label target must also be a child of the DummyLabel
--Both DummyLabel and Label must share the same settings
--Ensure that all children of the DummyLabel are set to scale with the object.
--The DummyLabel's opacity must be set to 0
behaviour("TextWithBackground")

function TextWithBackground:SetText(text)
	self.targets.DummyLabel.text = text
	self.targets.Label.text = text
end
